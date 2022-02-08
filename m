Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC688C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 19:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353601AbiBHTAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 14:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiBHTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C42DC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:59:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36EBA614D9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BD2C004E1;
        Tue,  8 Feb 2022 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346798;
        bh=5W5fPk5O+OhCfuvFpEPNFTFJHSo3n34jghpGXLn8aa8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jAAFXZ3uwrzI+tSd+DT22vrWw6TWL6e9qJ2AJDbBmJx6PHfFpL1DNaAPhe7KwSTNS
         oeng1Ngy5J8ihJpwlwbrYoM+InbF3Z+pi1kxLsm6O/eEjyYEvBWU2az1Jg32Cv1tua
         q+lV9OFEuF9HUYM6c5xPQoy/mbUlBCuFQTIk8rU06o1OXK+TXumAs4stZtFde2gFFn
         HSo7tGTlH/yT7WLTmp7K5ZjCCBLezK6vKZgahIIzPtHovYjUTNCwR5dBsszBsvmTNm
         1EnKiM7fp0mGLTPkFDM0MvJhp+CDz++Cxx7L55snhDct1FHuNUtLrts8vPMbAvvcXB
         EIjnLXOVwt9qQ==
From:   Mark Brown <broonie@kernel.org>
To:     kai.vehmanen@linux.intel.com,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        cezary.rojewski@intel.com
In-Reply-To: <20220120143741.492634-1-daniel.baluta@oss.nxp.com>
References: <20220120143741.492634-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH v3] ASoC: SOF: compr: Add compress ops implementation
Message-Id: <164434679640.1135369.1129624363357940675.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 18:59:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 16:37:41 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Implement snd_compress_ops. There are a lot of similarities with
> PCM implementation.
> 
> For now we use sof_ipc_pcm_params to transfer compress parameters to SOF
> firmware.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: compr: Add compress ops implementation
      commit: 6324cf901e14c6662be508f30485e0f09c54694d

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
