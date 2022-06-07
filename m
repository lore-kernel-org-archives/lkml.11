Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02741CCA482
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 11:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbiFGLBY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbiFGK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:59:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098BF1021C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50FDE615DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDA4C385A5;
        Tue,  7 Jun 2022 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654599297;
        bh=tH0f/y997NKkUUCgG9uAS0eF4X1+FPV2QFXnFMdScVM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UtLy796h/gSqQ5zF7TFUCkscQIyb7XkS44LyQ/VSZ8pRk1qjdpp8gLNKXIXNyx3oC
         05aQlbdTqJqkSW7FogtWrSFotZ5iirfhVmMV91zWJkudP/vxh2XZbkYVqh0xfr/cS2
         bvCWVWgfdaBkJFYAL28ERnq6U10H1WRCSSWIQ0XCvY/yaNQUj/V70sz8Zzx7pokrh/
         snQN7EJI66LNg1/ygV8pMZiLVscIczFGFu9QpToKqHAuPlbyDL+LBCuya7VXGzyWZu
         5UVxU3jdgdkVhj5p/f7qxCUhnYGYKKNwzbA0IuETZMeurEPBVFMxXqVkrBtX+3GCsV
         OI+9iGOr9ARyA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, vitalyr@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
References: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v3 00/17] ALSA: hda: cirrus: Add initial DSP support and firmware loading
Message-Id: <165459929623.399031.12790916846072977011.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:54:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 18:47:32 +0100, Vitaly Rodionov wrote:
> The CS35L41 Amplifier contains a DSP, capable of running firmware.
> The firmware can run algorithms such as Speaker Protection, to ensure
> that playback at high gains do not harm the speakers.
> Adding support for CS35L41 firmware into the CS35L41 HDA driver also
> allows us to support several extra features, such as hiberation
> and interrupts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[09/17] ASoC: cs35l41: Move cs35l41 exit hibernate function into shared code
        commit: 94e0bc317ad241c022a6bb311b3a28b4d51ea8b6
[10/17] ASoC: cs35l41: Do not print error when waking from hibernation
        commit: 97076475e2fdf471348b9ce73215cdbceeb4390f
[11/17] ASoC: cs35l41: Add common cs35l41 enter hibernate function
        commit: e341efc308e5374ded6b471f9e1ec01450bcc93e

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
