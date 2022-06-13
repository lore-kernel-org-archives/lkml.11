Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 18:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbiFMSRV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiFMSRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E79D06E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7992961123
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7D2C341C4;
        Mon, 13 Jun 2022 14:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655129792;
        bh=JeFRZNqiYXpunBIdaL1PQ/8lFK5kZkLfDEfX5hFl5sA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dX0qdg5uSftsgjhLrEKfyeoUByCvjN/ZRu7Jvv1ynttkcLxknNK4v6zz0NfxMuSCQ
         Hq4DeAqrg05j4xuUtSuyb+3YjdJqVMSWjs5TJ0ruOhjqAfQqYjgMqDkbiH1mIRTN/Z
         /+c+0RFDzSt21jtRjGxkY6I31kqUdRh6HxXTVMeuGyiLoy0RLc08OdUGCdZDU24Wqf
         mhBL90s1ZvNTdrylr3KDi6Gyfoq50KileGQwS7cjoVW2dlEDL5hbLVbmLLN9Rlk/EU
         wQs9Ur/RuKqL/le+6912fIm1lhJnA1foA6UK1jInE7NL1rZ7e2MNDkSHbFxlqQQBFa
         z7bj1UNcitT+g==
From:   Mark Brown <broonie@kernel.org>
To:     steve@sk2.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220607185304.1128962-1-steve@sk2.org>
References: <20220607185304.1128962-1-steve@sk2.org>
Subject: Re: [PATCH] regulator: rpi-panel-attiny: Use backlight helper
Message-Id: <165512979190.282085.15866686128241285278.b4-ty@kernel.org>
Date:   Mon, 13 Jun 2022 15:16:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 20:53:04 +0200, Stephen Kitt wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h.
> 
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rpi-panel-attiny: Use backlight helper
      commit: 8c92d9221d47ea97534888e2975ecd54896718d8

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
