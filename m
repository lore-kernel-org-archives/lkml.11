Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6191C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 13:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiBVNts (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiBVNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:49:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9589B108573
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 420A3B819DC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336DAC340E8;
        Tue, 22 Feb 2022 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645537758;
        bh=xzUHzcGPl4Q2K0Vdmgw54vA2PEe4Hf+75qHFGfoLrq8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MS3/qV6Z7Qd64rE2HlTvbxCYiOHXl46CgVCS+CPNkI3ZzrjmZ3MlFjWdIhdxz967S
         3OihToY26/TZitRXHsFni1noNhO3Ksl6arPFIqW8KIRg0lLQv3kcd+yTJst1rultmU
         NB/cv8BRB1t6PqHKAc8gUEvybWaD/7CgAndtXi29rnv9GmTbGvsyCqte6LV963IQ+8
         eKW2NssBlo1mb3YkRs0os9vMbE190U/4VHy8rNx2DpPSdg/8IWqv+nPlyKrNL0VO9k
         HrK5NoTDjNRALStoowiFkan2/LP87uNz7I5C4DuGqZjYF9dKdNyAAWh3yRfCTvQcKN
         gqTgeqA6qL3Bw==
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>
In-Reply-To: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
Subject: Re: [PATCH 0/3] regulator: da9121: update DA914x support
Message-Id: <164553775693.596513.14016754692281018447.b4-ty@kernel.org>
Date:   Tue, 22 Feb 2022 13:49:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 00:27:41 +0000, Adam Ward wrote:
> This series applies corrections and updates to DA914x support in the DA9121 driver
> 
>   - correct errors in current range
>   - update maximum voltage to spec update
>   - remove unwanted settings
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-linus

Thanks!

[1/3] regulator: da9121: Fix DA914x current values
      commit: f0fdfc04fd974cea23351b830fcac0822ea19a51
[2/3] regulator: da9121: Fix DA914x voltage value
      commit: c8c57fbc1c5067b913077e948c7d957af6834ba3
[3/3] regulator: da9121: Remove surplus DA9141 parameters
      commit: 9c7cf33c53ce833b58de9e5c192b4736dbd09cb1

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
