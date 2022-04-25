Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0867C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 17:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiDYR1U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbiDYR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56740E74
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B8A61581
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B87AC385AD;
        Mon, 25 Apr 2022 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907447;
        bh=s9MBnllajfacTuJ2LFd7tcHg09U6GQd9u2Gz1hjsecc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qZ7F4TLrdKnGBYfWTsWpQF3a4QoSZqUOdwclJrLRDj59B6EmQhRA7mWmRICZ+3na5
         fMIm9Y/HkZvPgUBg2Bm16Ggu5pb5SW2bWpINVryOGIeYMNpCWYGmCZHoYx6na/qBBv
         Vv6e2TKWUM6/jpWD0fTn3uo0DTO69NtUA4DFJYypYsbG3Nt6RtYNWGNefPLUuobwpb
         nSGJWRWOrh9mUQAfIiX6fgmTViFeZiCNUtap+urfjjoxEVprDDVyurPlNRThdc0Vxc
         dS59nyDGhnOOiUGexmY8z34fmQUvbMayjMMkAy4qQ04iUviRMhitoQmys+EBrnj9M8
         FyYmeNyYf8Mzw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cgel.zte@gmail.com
Cc:     alsa-devel@alsa-project.org, chi.minghao@zte.com.cn,
        zealci@zte.com.cn, linux-kernel@vger.kernel.org
In-Reply-To: <20220419110718.2574674-1-chi.minghao@zte.com.cn>
References: <20220419110718.2574674-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: img-spdif-in: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090744607.583823.4175599379103783503.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 11:07:18 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-spdif-in: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 6eaaf9bd9b4e3125779b292abd1c00b5baea67dc

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
