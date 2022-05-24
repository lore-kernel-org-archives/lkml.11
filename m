Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E063EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 22:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbiEXWeU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 18:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiEXWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:34:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAEE6D4C4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D744B81A52
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F28BC34100;
        Tue, 24 May 2022 22:34:11 +0000 (UTC)
Date:   Tue, 24 May 2022 18:34:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/2] tracing/probes: make match function safe
Message-ID: <Yo1dW2w1UIF+KZFw@home.goodmis.org>
References: <1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com>
 <1651397651-30454-3-git-send-email-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651397651-30454-3-git-send-email-quic_linyyuan@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami and Tom, what are you thoughts on this?

-- Steve

On Sun, May 01, 2022 at 05:34:11PM +0800, Linyu Yuan wrote:
> When delete one kprobe/uprobe/eprobe event entry
> using /sys/kernel/debug/tracing/dynamic_events file,
> it will loop all dynamic envent entries,
> as user will not input dyn_event_operations type,
> when call the match function of kprobe/uprobe/eprobe,
> the dynamic event may have different dyn_event_operations type,
> but currently match function may return a match.
> 
> Fix by check dyn_event_operations type first.
> 
> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> ---
>  kernel/trace/trace_eprobe.c | 31 +++++++++++++++++++++++--------
>  kernel/trace/trace_kprobe.c |  3 +++
>  kernel/trace/trace_uprobe.c |  3 +++
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index b16e067..0029840 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -19,6 +19,21 @@
>  
>  #define EPROBE_EVENT_SYSTEM "eprobes"
>  
> +static int eprobe_dyn_event_create(const char *raw_command);
> +static int eprobe_dyn_event_show(struct seq_file *m, struct dyn_event *ev);
> +static bool eprobe_dyn_event_is_busy(struct dyn_event *ev);
> +static int eprobe_dyn_event_release(struct dyn_event *ev);
> +static bool eprobe_dyn_event_match(const char *system, const char *event,
> +			int argc, const char **argv, struct dyn_event *ev);
> +
> +static struct dyn_event_operations eprobe_dyn_event_ops = {
> +	.create = eprobe_dyn_event_create,
> +	.show = eprobe_dyn_event_show,
> +	.is_busy = eprobe_dyn_event_is_busy,
> +	.free = eprobe_dyn_event_release,
> +	.match = eprobe_dyn_event_match,
> +};
> +
>  struct trace_eprobe {
>  	/* tracepoint system */
>  	const char *event_system;
> @@ -39,6 +54,11 @@ struct eprobe_data {
>  
>  static int __trace_eprobe_create(int argc, const char *argv[]);
>  
> +static bool is_trace_eprobe(struct dyn_event *ev)
> +{
> +	return ev->ops == &eprobe_dyn_event_ops;
> +}
> +
>  static void trace_event_probe_cleanup(struct trace_eprobe *ep)
>  {
>  	if (!ep)
> @@ -121,6 +141,9 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
>  	struct trace_eprobe *ep = to_trace_eprobe(ev);
>  	const char *slash;
>  
> +	if (!is_trace_eprobe(ev))
> +		return false;
> +
>  	/*
>  	 * We match the following:
>  	 *  event only			- match all eprobes with event name
> @@ -174,14 +197,6 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
>  	return trace_probe_match_command_args(&ep->tp, argc, argv);
>  }
>  
> -static struct dyn_event_operations eprobe_dyn_event_ops = {
> -	.create = eprobe_dyn_event_create,
> -	.show = eprobe_dyn_event_show,
> -	.is_busy = eprobe_dyn_event_is_busy,
> -	.free = eprobe_dyn_event_release,
> -	.match = eprobe_dyn_event_match,
> -};
> -
>  static struct trace_eprobe *alloc_event_probe(const char *group,
>  					      const char *this_event,
>  					      struct trace_event_call *event,
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 2cd8ef9..f63abfa 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -163,6 +163,9 @@ static bool trace_kprobe_match(const char *system, const char *event,
>  {
>  	struct trace_kprobe *tk = to_trace_kprobe(ev);
>  
> +	if (!is_trace_kprobe(ev))
> +		return false;
> +
>  	return (event[0] == '\0' ||
>  		strcmp(trace_probe_name(&tk->tp), event) == 0) &&
>  	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0) &&
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index a935c08..ee55ed0 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -312,6 +312,9 @@ static bool trace_uprobe_match(const char *system, const char *event,
>  {
>  	struct trace_uprobe *tu = to_trace_uprobe(ev);
>  
> +	if (!is_trace_uprobe(ev))
> +		return false;
> +
>  	return (event[0] == '\0' ||
>  		strcmp(trace_probe_name(&tu->tp), event) == 0) &&
>  	   (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0) &&
> -- 
> 2.7.4
