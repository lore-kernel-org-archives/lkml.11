Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA1FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 07:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbiFIHpS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiFIHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:45:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2AA1A398;
        Thu,  9 Jun 2022 00:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 546E2B82C1F;
        Thu,  9 Jun 2022 07:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DA6C34114;
        Thu,  9 Jun 2022 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654760711;
        bh=2LL7+wgynfXqSoybroZDLmD28F35k05LG/4YKWxg6ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3acwFCjdjQ6OEXtnuqNMjF45pE4qMIt3/k1ZOYvk9Jkw07UrLmsGmqlQc1SjPtiL
         UL0bOGGad0zLb8TcLC72qe6E1jiHs33vcrilaAofu96KN+mR74SNFsAyp7VfDfoQn/
         JE939YUHMOIyM0GlaCxHywQli/BaXd5x5i+c/cdzglJSugiADlaIOm049KAiTi7Ezi
         QeZexJdKXMuPio77uB6vjicQIS+ODyTguK0WsbnJxNARn8POAqfrNB9/nkFtG55zYN
         8Zi4p2KrfvEx+C6mc9ICdJjniTC1a27cJeqmdoOERkFMgvDQ8VUHpXBvMYCFEoWis6
         713CYN6SH5nlg==
Date:   Thu, 9 Jun 2022 07:45:07 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/5] platform/chrome: cros_kbd_led_backlight: separate
 ACPI backend
Message-ID: <YqGlA/5CK4lX95ge@google.com>
References: <20220523090822.3035189-1-tzungbi@kernel.org>
 <20220523090822.3035189-3-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523090822.3035189-3-tzungbi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 05:08:19PM +0800, Tzung-Bi Shih wrote:
> cros_kbd_led_backlight uses ACPI_KEYBOARD_BACKLIGHT_WRITE and
> ACPI_KEYBOARD_BACKLIGHT_READ for setting and getting the brightness
> respectively.
> 
> Separate ACPI operations for preparing the driver to support other
> backends.

The patch is the last one in the series that hasn't got a R-b tag.

I have tested the patch on an ADL-P-based chromebook and the keyboard
backlight works.  Could anyone on the list help to review the patch?
