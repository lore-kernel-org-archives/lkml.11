Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A680DC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiEQGqH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiEQGqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65684205C7;
        Mon, 16 May 2022 23:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1BD76147F;
        Tue, 17 May 2022 06:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53613C385B8;
        Tue, 17 May 2022 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652769959;
        bh=005Cq1wFvYS3aEWbca+TxQNtYui1BArspQR2qt7J64I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mLWNjEdrU4oTHgBJBK7baKTFX8Kt5UkODV1Cf3lqIuACyULiVt/xhA17MwMUWF87N
         9zSL3rOuDttFBHlqiGlM2SmpGxjEtQF/b2Sb8qMEKUqnzJ3D4EfuEWUpGbf0QiVeOV
         pokEknhi5Aq65O/xw/1VnD/0jFy9ziccj0paDEyHPSeY6bISXbAYHMwC3eygRs7cMj
         YmYLBTEzb89QXz7mQAlyTu+tIzjOQwJduEUJbDEBVwkGASM4EYam6AtUbuF6e3jvg7
         gj0avql0fElJo6BLDiBcZjkpRQ9zY9Bv/epOTsY/FI1pW6Wq5CYPiCgtoNAFi/BpW1
         Jun/6D8tpFuDA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220509092102.140520-1-lizhengyu3@huawei.com>
References: <20220509092102.140520-1-lizhengyu3@huawei.com>
Subject: Re: [PATCH] clk: fixed-rate: Remove redundant if statement
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, mturquette@baylibre.com
To:     Li Zhengyu <lizhengyu3@huawei.com>
Date:   Mon, 16 May 2022 23:45:57 -0700
User-Agent: alot/0.10
Message-Id: <20220517064559.53613C385B8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Li Zhengyu (2022-05-09 02:21:02)
> (np) is always true when (dev || !np) is false, so just remove
> the check.
>=20
> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
> ---

Applied to clk-next
