Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88799C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 19:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384189AbiDUTVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDUTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3375E4B415
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C440061A3E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAAEC385A7;
        Thu, 21 Apr 2022 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650568698;
        bh=HOdy8VUWf3kV6Iqxji46w9RRT+an7kD/+0PjvVrebC4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jgiChYOtfVG+bjOC1HbHAqw8uFBBlouq3zey0JPnHtMBGX77EGYggPfBdRx4ye+wB
         zAqaZI7cmPrEdaX1d9gwMM5oEk4K4vCTWHOJLj4SjyaitBPMuUNJ5XigQ08cYmzrD+
         WgWVFOsSUzGEv1UTqitLwEvy+8qQ4Akog/+lvRV1gDwpmX6ixAvbZ6Gk+O14CCqS/8
         4MfP/DoDYqLE3rCEZyDSN2+iNhfO7T7H6zeErp5WDY+yjDMEZIS+L6X0Z78Md1TJIJ
         97GJgz7YtYk5/Au9gt/dDybGqrD2OFQ2gxzyZULJg8ut4ZYkidolE/CnjN3Fn71pJl
         Ye2oJZmiR8+Mg==
From:   Mark Brown <broonie@kernel.org>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, dimitrysh@google.com
In-Reply-To: <20220421155725.2589089-1-narmstrong@baylibre.com>
References: <20220421155725.2589089-1-narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] Revert "ASoC: meson: axg-tdm-interface: manage formatters in trigger"
Message-Id: <165056869649.409171.13055364117592401974.b4-ty@kernel.org>
Date:   Thu, 21 Apr 2022 20:18:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 17:57:24 +0200, Neil Armstrong wrote:
> This reverts commit bf5e4887eeddb48480568466536aa08ec7f179a5 because
> the following and required commit e138233e56e9829e65b6293887063a1a3ccb2d68
> causes the following system crash when using audio:
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:282
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] Revert "ASoC: meson: axg-tdm-interface: manage formatters in trigger"
      commit: c26830b6c5c534d273ce007eb33d5a2d2ad4e969
[2/2] Revert "ASoC: meson: axg-card: make links nonatomic"
      commit: 0c9b152c72e53016e96593bdbb8cffe2176694b9

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
