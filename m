Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D34C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 15:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiEYPZ6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiEYPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24073B043D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6973A60DD4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122B3C385B8;
        Wed, 25 May 2022 15:25:52 +0000 (UTC)
Date:   Wed, 25 May 2022 11:25:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gautam Menghani <gautammenghani201@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kernel/trace: Initialize integer variable to prevent
 garbage return value
Message-ID: <20220525112551.37e86da6@gandalf.local.home>
In-Reply-To: <20220522061826.1751-1-gautammenghani201@gmail.com>
References: <20220522061826.1751-1-gautammenghani201@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 23:18:26 -0700
Gautam Menghani <gautammenghani201@gmail.com> wrote:

> Initialize the integer variable to 0 to fix the clang scan warning:
> Undefined or garbage value returned to caller 
> [core.uninitialized.UndefReturn]
>         return ret;
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  kernel/trace/trace_boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 0580287d7a0d..778200dd8ede 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -300,7 +300,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
>  {
>  	struct xbc_node *node;
>  	const char *p, *handler;
> -	int ret;
> +	int ret = 0;

Looks good to me. Masami, care to ack it?

-- Steve

>  
>  	handler = xbc_node_get_data(hnode);
>  

