Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 03:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiDRD2b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 23:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiDRD23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890ACDFB0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 20:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23A8E60F5A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A69C385A4;
        Mon, 18 Apr 2022 03:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650252350;
        bh=dhF3VAnr2KENNVesIXWBrCcRVnkM3rSZ0f7/dVXqQqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgrz1DrUV07KwS+fhEmDTsl/y/bUF5GnfBaa4G4KeP5nKdpjS5cmzzSyVvpmoxcRD
         89FiFojcrHCq8iXgsxg5lESCAmW55nTYtOJs+M1sr4vnJkoE3E4sBWT6qOrf/Shg5/
         Umv7MKVL7e1cutST2LmbWY0Nk+szl997yjWDxbLvh0JG7sv2c6+YZL+pGXHg4omSNP
         TrzhEflESK+mRcaGIh6xTEkryOwxAawkNgunoNQ97aRZssFeoFY3+YGfwul6IcjbQl
         6DPhkxioHLTVhqpHBT05fHkV3xgC6wZ+iGktZVcvkPmabM+814JIpniHsXaay/uJyQ
         Hkqq1WRA2qEbA==
Date:   Mon, 18 Apr 2022 11:25:46 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 2/3] mfd: cros_ec_dev: Only register PCHG device if
 present
Message-ID: <YlzaOl4PGyTG6eqB@google.com>
References: <20220415003253.1973106-1-swboyd@chromium.org>
 <20220415003253.1973106-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415003253.1973106-3-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:32:52PM -0700, Stephen Boyd wrote:
> Don't create a device for the peripheral charger (PCHG) if there aren't
> any peripheral charger ports. This removes a device on most ChromeOS
> systems, because the peripheral charger functionality isn't always
> present.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daisuke Nojiri <dnojiri@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <chrome-platform@lists.linux.dev>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Share the same comment with the 1st patch in the series,
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
