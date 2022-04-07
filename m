Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E31C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 09:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbiDGJlM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 05:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiDGJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8A1B2161
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BFE661864
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42B3C385A0;
        Thu,  7 Apr 2022 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324302;
        bh=TNEhWEcbjVm0jSKmKL51ANFFVzUTdaJeILNY7yjz2wE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AkNzu5jVfmFLbY73qSLFCkKgbC5mQU8ox5OhjQrnqsajckQcDygHtwot08RpbpgV7
         WdwNcZ3dihjkVHkjvPYc/QK0QmTtunaR+o65UT1rmyElyIzdEjw9WnzNRMFT2BmXcP
         zHqVyIhcj6c+PJuWzfYvuiO2AEaSP6+U6KS0SFcL7t9ZYG4GCvNQ7V/v2svMEb/Fw9
         qRsBxnn0LhfDx1KgGQJH7vdYJx38aXOeAvFIOj6fFBBZAcI2ghlpZQM/l1fL9hro+L
         gTFPrLhYsZKA3NKeolatR8eo4NioBX6IpUbwfN0tw9hgPn62aLFLnNEllnPV1bzDhd
         GBehfKplDTV0Q==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, nizhen@uniontech.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220314054621.14694-1-nizhen@uniontech.com>
References: <20220314054621.14694-1-nizhen@uniontech.com>
Subject: Re: [PATCH v2] ASoC: Intel: boards: Use temporary variable for struct device
Message-Id: <164932430152.3844153.10230903353373172658.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 13:46:21 +0800, Zhen Ni wrote:
> Use temporary variable for struct device to make code neater.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: boards: Use temporary variable for struct device
      commit: 8b3520f7f6f6b54bb6b6e50b88f707a6b8113887

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
