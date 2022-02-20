Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DAC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 17:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbiBTRIo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:08:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBTRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:08:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA9433AF;
        Sun, 20 Feb 2022 09:08:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9F89CE0BAA;
        Sun, 20 Feb 2022 17:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D1DC340E8;
        Sun, 20 Feb 2022 17:08:15 +0000 (UTC)
Date:   Sun, 20 Feb 2022 12:08:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Shiang <oscar0225@livemail.tw>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Remove duplicated words in trace/osnoise-tracer
Message-ID: <20220220120814.4f593555@gandalf.local.home>
In-Reply-To: <TYCP286MB1913117487F390E3BCE38B15A1399@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB1913117487F390E3BCE38B15A1399@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2022 20:12:00 +0800
Oscar Shiang <oscar0225@livemail.tw> wrote:

> There are 2 duplicated words found in osnoise tracer documentation.
> This patch removes them.
> 
> Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  Documentation/trace/osnoise-tracer.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
> index b648cb9bf..963def9f9 100644
> --- a/Documentation/trace/osnoise-tracer.rst
> +++ b/Documentation/trace/osnoise-tracer.rst
> @@ -51,7 +51,7 @@ For example::
>          [root@f32 ~]# cd /sys/kernel/tracing/
>          [root@f32 tracing]# echo osnoise > current_tracer
>  
> -It is possible to follow the trace by reading the trace trace file::
> +It is possible to follow the trace by reading the trace file::
>  
>          [root@f32 tracing]# cat trace
>          # tracer: osnoise
> @@ -108,7 +108,7 @@ The tracer has a set of options inside the osnoise directory, they are:
>     option.
>   - tracing_threshold: the minimum delta between two time() reads to be
>     considered as noise, in us. When set to 0, the default value will
> -   will be used, which is currently 5 us.
> +   be used, which is currently 5 us.
>  
>  Additional Tracing
>  ------------------

