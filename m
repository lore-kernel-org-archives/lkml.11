Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4955CC4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 22:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352388AbiCOWuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 18:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352377AbiCOWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296175D1A8;
        Tue, 15 Mar 2022 15:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBF6C61463;
        Tue, 15 Mar 2022 22:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0F4C340E8;
        Tue, 15 Mar 2022 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647384542;
        bh=g0OpN289mv7nvfnKGCGmf+rrL1H85SzTDW50hzuAF5s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BC+IM1hkmFrODWmov045SpoXC9QQVPeujNrAhIG4piW99GhYirG4aiGlQJkyprmSG
         pxiMx7RGuROBucC8H7SRp6yj6ag7CaL1w+e+MwWrqLx6ZPfbWV2kdt8BN4IKMkEXzc
         rzECpAMIr/4zrHiy6Aw7WjJqaRdFEe2mSeeX6S+DFe35UHWiW2MNSuRQA4Mzv3uzTk
         TxDN4FnT5uFglldJMcNGd5AeMKIocxaAolZOGdI5gOE3ajAwJ0kNKEjY1IZFXBDHxS
         WZErS74bORdtSPbvyjzqzsRzvJHoXtS7+ihMPefj1NuLfHua65CHHpR9nSo5oYxJRz
         3CYlzYgGghnfg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220314115354.144023-16-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-16-Julia.Lawall@inria.fr>
Subject: Re: [PATCH 15/30] clk: qcom: sm6125-gcc: fix typos in comments
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Date:   Tue, 15 Mar 2022 15:49:00 -0700
User-Agent: alot/0.10
Message-Id: <20220315224902.1C0F4C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julia Lawall (2022-03-14 04:53:39)
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---

Applied to clk-next
