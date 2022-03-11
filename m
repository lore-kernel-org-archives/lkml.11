Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D20DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 20:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351204AbiCKUXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 15:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351200AbiCKUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:23:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C727560E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:22:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FAC0B82CF5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 20:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA2FC340E9;
        Fri, 11 Mar 2022 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647030161;
        bh=YsBWt/1b/coRAuiW5Ll4OeIE+LbscJPmSqzzxWr+rrU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O9CsUPvjz4zuDnPlbI3VSsZvEPqDx0EXOWENHempxe6HEPAZ9WK3J+b8Toboe1bWZ
         XZNUmWjHHiJFPJgdHVFjpdQ8WWYkHd7ebhZHkx/5IzNDO99ocMO/jrTFSwyqB3Z/Bu
         C3iD5ZjwPENr+eHpjfPt7QtX6pR6pmqqx3NA6tlPfZGwy497Obm/z9NhhMuMKc3XvS
         4Pg+HQxkn/5kH0gGnveRSsJt3ryyudUCzXo+5O9rb8kw2FFrsKV997CDuA8ZEn2FuN
         VNhgy2UdwhFSPQ6adIrKN6n4EG7gDvG2PV072pmgtqlV/3w2EECB0rg05XCj2Y6Qzm
         NJgwOoRq7FPJw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        Sameer Pujar <spujar@nvidia.com>
Cc:     stephan@gerhold.net, robert.hancock@calian.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com
In-Reply-To: <1646910999-2501-1-git-send-email-spujar@nvidia.com>
References: <1646910999-2501-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: Don't reset clock of active DAI
Message-Id: <164703015990.264137.12664948520166474876.b4-ty@kernel.org>
Date:   Fri, 11 Mar 2022 20:22:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 16:46:39 +0530, Sameer Pujar wrote:
> Playback or capture errors are seen when clock is reset during an active
> stage of DAI. Presently this scenario happens when DAI has both playback
> and capture sessions running and one of these finishes first which will
> be followed by clock rate reset. The remaining active session will be
> affected in such case.
> 
> Address this problem by allowing clock rate reset to happen only when
> the DAI is no more active.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card-utils: Don't reset clock of active DAI
      commit: 5bbe2918acccfa60de1c1a2139de9cc5441d5796

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
