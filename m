Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD21C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 06:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiHHGHP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 02:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHHGHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE0610B8
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32B15611CC
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E5FC433C1;
        Mon,  8 Aug 2022 06:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659938831;
        bh=BeJ/5CXgtTEWpJK23C0F6E+yUTy2LMEwm0F/7sKgZb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgQ3B5svGytonlkpnAQtF6NzuOZwdq006a15FQA6MiMkXmaGppGoUIptlzwmh4jS3
         KLFmZo7418CeUNup627yaJYuxcVHpMXcYxJF6YL90DV0TRlKfEoxwLSOa1Hg7S4zew
         +2adHrBxqK3iGff1S/5iIyhPnr62O6Rk9roodsHKUI/nNtaoelTj48rpNoUI41vYVa
         rSbe5RyYxiUN/kYc0R7nQc6BKfmVMmKxfzPpwkdgK09PUcfYmzsYpuMGUzYSy/wsHX
         SXkoNWoWzs3ktOTxUSpVN9cYiYN+zGUzvuon26hLEruKzg1iOhNVXShVrrYiV64VRo
         jU8ZTV9EK7EJg==
Date:   Mon, 8 Aug 2022 06:07:07 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajat Jain <rajatja@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec: Expose suspend_timeout in
 debugfs
Message-ID: <YvCoC0T3ZhKzeYvB@google.com>
References: <20220805151551.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805151551.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:17:17PM -0700, Evan Green wrote:
> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> index 1fe0add99a2a99..8e7e76e6481550 100644
> --- a/Documentation/ABI/testing/debugfs-cros-ec
> +++ b/Documentation/ABI/testing/debugfs-cros-ec
> @@ -54,3 +54,25 @@ Description:
>  		this feature.
>  
>  		Output will be in the format: "0x%08x\n".
> +
> +What:		/sys/kernel/debug/<cros-ec-device>/suspend_timeout
> +Date:		August 2022
> +KernelVersion:	6.0

The merge window is opened.  It's too late for the patch if the following
outcome version is 6.0.

> +Description:
> +		Some ECs have a feature where they will track transitions to the
> +		a hardware-controlled sleep line, such as Intel's SLP_S0 line,
> +		in order to detect cases where a system failed to go into deep
> +		sleep states. The suspend_timeout file controls the amount of
> +		time in milliseconds the EC will wait before declaring a sleep
> +		timeout event and attempting to wake the system.
> +
> +		Supply 0 to use the default value coded into EC firmware. Supply
> +		65535 to disable the EC sleep failure detection mechanism.

Better to mention EC_HOST_SLEEP_TIMEOUT_INFINITE or [1] in the description.
Or, it's not obvious from the patch that 65535 disables the mechanism. 

[1]: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/power/host_sleep.c
