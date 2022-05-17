Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A548CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 15:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350752AbiEQP7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350743AbiEQP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E594FC5F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A9B61230
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BFDC34118;
        Tue, 17 May 2022 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803178;
        bh=3pOjCkAU200y6m9nlnhOIQw/WFG50rXKot5rpFhX6us=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=M3QEnWDdlSHJyGbFL1cs75vxvYtgKutUZVOTn5mTLQoU35BxHWb3uuvhG++9mQp5U
         2Ep5awWCXz7yxd5JZyXoqFRnL3GyvIK3mk3UixU2HIervwLCuh3tkSKvwwHFljBilF
         qDCixSCdaTUmmg1UeBUFhc3edTRqmc7XJEwS0RKXH2I9i6cdYScEG4QF7r+cpnvRdR
         ZkkKKRnoihOQVkueV/6Uad00a93Goh5oGE++8iQuHO6ur4xxY97+HbtFoOV/zom1QH
         RZzUAhyKeFGOQNrFFygst/D0bgwUtuLiTWSXQqTsCHIgeql/tdvSn85Gn0edL3TGwH
         VowOkJvIj8xqQ==
From:   Mark Brown <broonie@kernel.org>
To:     hanyihao@vivo.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220517033050.5191-1-hanyihao@vivo.com>
References: <20220517033050.5191-1-hanyihao@vivo.com>
Subject: Re: [PATCH] ASoC: ux500: mop500: Check before clk_put() not needed
Message-Id: <165280317718.1635268.9001989398219393939.b4-ty@kernel.org>
Date:   Tue, 17 May 2022 16:59:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 20:30:46 -0700, Yihao Han wrote:
> clk_put() already checks the clk ptr using !clk and IS_ERR()
> so there is no need to check it again before calling it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ux500: mop500: Check before clk_put() not needed
      commit: 37a86b32bf0e5c5ca23567d7b120306b9ac8497d

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
