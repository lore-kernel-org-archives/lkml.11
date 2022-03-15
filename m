Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4EFC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 23:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352692AbiCPAA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiCPAA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C6655750;
        Tue, 15 Mar 2022 16:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F313361537;
        Tue, 15 Mar 2022 23:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCC8C340E8;
        Tue, 15 Mar 2022 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647388783;
        bh=9b4hTTeP0bR6aPn4lwbDneU/xQj2l5nU58aIBNZnOSY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hw5xvUyuMU09/78n9pIJpYJYkgzXnqi279u8niki5jTOGhhNFGXaIaG7MvawTgj7/
         XdwFQT0HMYISTpkUvALPzJxtcHB1NRvJULZYPq6WCFWS9DTSjJZsogT+B27HN0/y98
         MRFooug6KIHow/XqbcVyonJyB4oOj3UPdUQ0iYC93dhTj+BG+PNRJCqhGAG+Iod2JJ
         I5AUrgVHJP4vEmHFfSjLbIAls02GHDCQr7KE8GnBZmqsJoQnB82RFWs+fQsHLsqQTy
         jbVNT5nIB7g7TyygYi89ov29KlfaNbaL1Ym28m0bsf4nQMUKF9FMn71wHvoaEay1Z8
         8sSI8kfH5YEOQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8cfd57f01cfb59adb716eb13ca0c8250c246dcb2.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com> <8cfd57f01cfb59adb716eb13ca0c8250c246dcb2.1646388139.git.zong.li@sifive.com>
Subject: Re: [PATCH v2 1/5] clk: sifive: duplicate the macro definitions for the time being
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>
To:     Zong Li <zong.li@sifive.com>, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Date:   Tue, 15 Mar 2022 16:59:40 -0700
User-Agent: alot/0.10
Message-Id: <20220315235943.4FCC8C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2022-03-04 02:03:17)
> This is a temporary patch in whole patch set. We are going to change the
> macro name in dt-binding, in order to avoid breaking the driver build
> and git bisect, add these macro definitions for the time being, and we
> will remove them later.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---

Applied to clk-next
