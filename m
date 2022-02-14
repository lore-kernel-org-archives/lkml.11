Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59961C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 16:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356409AbiBNQcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:32:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiBNQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:32:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6110B67
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:31:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1FCFECE19D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1275C340E9;
        Mon, 14 Feb 2022 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856310;
        bh=1wqWngPBeYFF/RRK8XYodlEqQYdd8dG1dgq3lciQsFI=;
        h=From:To:Cc:Subject:Date:From;
        b=aJYhgMOW6NITxS+EbwOJG0W2+9K8Y9LGU2lVIgjaR63PLtgEG0hng5Kh7xzOwTk1d
         7OzPTHXHLCQtEaCyVhQC4vR0ALqFSzoAjPz1omjkAoY3EZlSg7JxTy3XWdH5nw0W76
         SkHzB4FYPfkqY+5CgzKq8lOTODrc5DONDFWRkAxmqE+kA0CDagmsdG7XDL2jqqb785
         OruB+RovFUtjRfyznW4Hs6Lc7AjKTA5DmtF02I2gRvHa9Zmb5m9dsVS+km+KZlq9Vx
         23qmQOXMUFsihb9DsJnH8UCMtBKADxGm3jK8lA+zkbPT0BttKOTqyrF+5onFGIhADd
         Gq7uf/PdNhQ8w==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.17-rc4
Date:   Mon, 14 Feb 2022 16:31:42 +0000
Message-Id: <20220214163149.D1275C340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b4c18c18ebf7cf1e602af88c12ef9cb0d6e5ce51:

  regulator: MAX20086: add gpio/consumer.h (2022-01-19 16:47:39 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc4

for you to fetch changes up to 4e2a354e3775870ca823f1fb29bbbffbe11059a6:

  regulator: core: fix false positive in regulator_late_cleanup() (2022-02-08 13:37:48 +0000)

----------------------------------------------------------------
regulator: Fix for v5.17

One fix here, for initialisation of regulators that don't have an
in_enabled() operation which would mainly impact cases where they aren't
otherwise used during early setup for some reason.

----------------------------------------------------------------
Oliver Barta (1):
      regulator: core: fix false positive in regulator_late_cleanup()

 drivers/regulator/core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)
