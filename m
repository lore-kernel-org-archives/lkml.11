Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B591ECAAD5
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 12:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiHaMlE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHaMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D33ED4D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A21F61982
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88230C433D7;
        Wed, 31 Aug 2022 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661949658;
        bh=VJzf5SMukgnOhcfk4fRzmhPNEX69oZvYp5xql0sUwi0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hflMLsoM4EqU3I+v34GfrKGbKTnEwZVp+bhQtI8fx92UthCxDhYmcB8MiNGbl19AN
         wd125Tn64emwO8sVfyV3i16ZNCWCzqQRshFITpVVYMQSAL9+Qx+bmE/NvM+jgJcj9k
         L/7xwiOCD4/rfvhzWMG1wy+1PThCVULGX1KJj+0rqmrpTe3Jg6M/1uCU0dDwSl2jy4
         dT7g/PevZM1wXs3P7KtHUVafQAw+pW7UjJQM7j9wNRu8rRMb4o9VQhb1vR2LKLMqg7
         hSaboqse8641rFF0GA/NB+Gm8cJzfHNRL3FQ4t7xZwEI628lFgGaH8oAnNCjWOKkw6
         UYiDjTkJz1jnw==
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        alsa-devel@alsa-project.org
Cc:     V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Jaroslav Kysela <perex@perex.cz>,
        ssabakar@amd.com, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Sunil-kumar.Dommati@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220801063501.51439-1-venkataprasad.potturu@amd.com>
References: <20220801063501.51439-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: acp: Modify dai_id macros to be more generic
Message-Id: <166194965527.85274.9760279024689489230.b4-ty@kernel.org>
Date:   Wed, 31 Aug 2022 13:40:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 12:04:56 +0530, Venkata Prasad Potturu wrote:
> Change dai_id macros to make I2S instances in order.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Modify dai_id macros to be more generic
      commit: 99a387c7818fe422fa96458f56bc74f05f263013

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
