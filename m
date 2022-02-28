Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73057C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 19:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiB1TQV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiB1TQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:16:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D84E38A4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:15:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F27CA61585
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E1DC340F3;
        Mon, 28 Feb 2022 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646075737;
        bh=QMnH25jeKQK2fr6BizBXEDFvSipSItzPlv7VILXcuB8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qn1xxKzrBMx6gzQOnPPikBTdhge6w+TPfpMphxMBnscom5bnyygc/8+0MtZxR/mlF
         lQMZXw7xF93AQ8LF/0IHoO5yolN9gSPcFnO2mXiVfL9On7Js+kcjllsTv3C8nVXm9e
         o4jzyaBbq+WKIijT+/QyE9p2HyeW53fYW340f1KSuRXF4lhKkHJR2oxXunEg3BaGHX
         4hxIC+ABh5JmFgS84rMlOfNi1M0kuHEGkKNLESRzeImbLuWx4iasiIOItTsfJxwIkY
         T9EDk1wClMIGRFsjjLWkN7DYnS5ckZf9+zYWO/D5QEvFSpjvrzVaCzlqLFNMxIhmK8
         16MyVlXgjk/zg==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220224011046.76904-1-yang.lee@linux.alibaba.com>
References: <20220224011046.76904-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: mediatek: mt8195: Remove unnecessary print function dev_err()
Message-Id: <164607573514.3538791.6139956984733372716.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 19:15:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 09:10:46 +0800, Yang Li wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> Eliminate the follow coccicheck warning:
> ./sound/soc/mediatek/mt8195/mt8195-afe-pcm.c:3126:2-9: line 3126 is
> redundant because platform_get_irq() already prints an error
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Remove unnecessary print function dev_err()
      commit: 7d642c9c14b6fae0c05b91a92a86fae6674a2126

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
