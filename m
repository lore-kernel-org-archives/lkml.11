Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B924C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349100AbiCHRYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349283AbiCHRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:22:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE754BF2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9EA161256
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C297C340EB;
        Tue,  8 Mar 2022 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760063;
        bh=VXtXZwmTg2CbEhaflPUS8x55Hns993/Kt31uJMvMLc8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=tW64Ce1U/EXWJOzttKG02pKqy8yiAZ70nH7BuHMz+MNAdF4xKAk9EreguqHoWCcRM
         cjwQqF3L4KsOt+qTMEQCwZHJKe2t+FhbZoaQ7fYpHuydx9MDYwf1NN0aaP2ymzJNV8
         3Ij3yHlCb9vnWoC2lSpDTQIgrVNGiZ1Z9WaJ8XY2VvziCg8VEqSwZ3JHbPlXW8s9LL
         tjHJa3rfNX8GmTa34F07Dej2TMTcWG75LyNtEGt5FL+8GxDv3FjqwptnClpjgtxUds
         TphFgFT8MywsNP4ofWThY1I9VFfw6XAOKV1ONQTUheu8WCHrh/Zkfx9cv6mUZ6QdDl
         3kwuI5Kcm61Ng==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20220308015224.23585-1-linmq006@gmail.com>
References: <20220308015224.23585-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192-mt6359: Fix error handling in mt8192_mt6359_dev_probe
Message-Id: <164676006096.54315.8478351478662604607.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 01:52:22 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> Fix this by calling of_node_put() in error handling too.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192-mt6359: Fix error handling in mt8192_mt6359_dev_probe
      commit: e45ac7831ff3e2934d58cce319c17c8ec763c95c

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
