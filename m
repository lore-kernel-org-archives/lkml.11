Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B95C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 08:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiGNIbz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 04:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiGNIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:31:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B57E286FC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:31:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1E0A207F4;
        Thu, 14 Jul 2022 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657787509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wxiNVePi8CjV+QzTOh4pfubrKeQewdF1ahtQz8klmo=;
        b=AI4JPjq92/yZ9Y6tq7MeiDgcuZCtnXkvSQaQltDTZtmPySxD48yENQb9kNMUNj5ZYa63tI
        iaWQrT4Y4WnCwHFHXDd4M/OxEJnovpRPxVQwEkfnE2XewEZcV1kOnpa7VryjoHJ3pEEKi+
        gySOnmTTWubEDbyGG3pvQYhnzxExm2w=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59D6E2C1B8;
        Thu, 14 Jul 2022 08:31:45 +0000 (UTC)
Date:   Thu, 14 Jul 2022 10:31:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Gavin Keusch <gavinkeusch@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kernel: watchdog: fix missing space coding style issue
Message-ID: <20220714083149.GC2737@pathway.suse.cz>
References: <20220714060457.96599-1-gavinkeusch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714060457.96599-1-gavinkeusch@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Andrew into Cc who usually takes patches for kernel/watchdog.c.

Best Regards,
Petr

On Wed 2022-07-13 23:04:57, Gavin Keusch wrote:
> Fixed missing space causing coding style error
> 
> Signed-off-by: Gavin Keusch <gavinkeusch@gmail.com>
> ---
>  kernel/watchdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index ecb0e8346e65..b6b150c4b179 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -306,7 +306,7 @@ static int is_softlockup(unsigned long touch_ts,
>  			 unsigned long period_ts,
>  			 unsigned long now)
>  {
> -	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
> +	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh) {
>  		/* Warn about unreasonable delays. */
>  		if (time_after(now, period_ts + get_softlockup_thresh()))
>  			return now - touch_ts;
> -- 
> 2.34.1
