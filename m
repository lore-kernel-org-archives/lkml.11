Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2C9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbiEXSZa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiEXSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4BC8A303
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0608F6157A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200AAC34100;
        Tue, 24 May 2022 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653416725;
        bh=IsSqmCDUURr9/5xQZSxVskm0kP7w7Lk6OXH98DkMxv4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IRVqMZMQYCBDCqMfRZHNB4oBMjtiMmAOnh2oO2C3JU3X6R3KV4Eoc7nxv6wY2I5zE
         KWpsOjPpSv2/PsIotxxsSodb80eyhiv2ruoXAN9ZoS8XYdWmbbHt+1khksFF0oByGd
         ES+3MycjpJXHEgHOEVJRdoUmbWJEe5XHtUSPku79MBb02/bGgjHS2zrrmA5SeMdmCW
         llgH5TQzJnesP0StWWrAnVpWDKElevgGxahS88yFGkfjyPvkPJeBERiusVBp500GxJ
         3kPMg5pV4BykiFDsWEwPzyTyCUBbl5OSfSb+Onrx0yNWFeiTWwwa/BMA6xF3Zso5Vw
         Jo0qji14Bp7xg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, ssabakar@amd.com
Cc:     Vijendar.Mukunda@amd.com, Sunil-kumar.Dommati@amd.com,
        AjitKumar.Pandey@amd.com, linux-kernel@vger.kernel.org,
        Basavaraj.Hiregoudar@amd.com, tiwai@suse.com, lkp@intel.com,
        ajitkumar.pandey@amd.com, lgirdwood@gmail.com, perex@perex.cz
In-Reply-To: <20220523112956.3087604-1-ssabakar@amd.com>
References: <20220523112956.3087604-1-ssabakar@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: Fixed Build error
Message-Id: <165341672284.1497256.4768954734853451749.b4-ty@kernel.org>
Date:   Tue, 24 May 2022 19:25:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 16:59:53 +0530, Syed Saba kareem wrote:
> Add linux/module.h in acp-pci.c to solve the below dependency
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> sound/soc/amd/acp/acp-pci.c:148:1: warning: data definition has no type or storage class
> 148 | MODULE_DEVICE_TABLE(pci, acp_pci_ids);
> | ^~~~~~~~~~~~~~~~~~~
> >> sound/soc/amd/acp/acp-pci.c:148:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
> ...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: Fixed Build error
      commit: 803a1f7272797faa15a7879cdc70f9adaf3fdcba

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
