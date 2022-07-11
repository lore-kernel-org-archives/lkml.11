Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 20:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiGKUaH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiGKU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:29:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242EC8CC90;
        Mon, 11 Jul 2022 13:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C08E761647;
        Mon, 11 Jul 2022 20:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198F4C34115;
        Mon, 11 Jul 2022 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571260;
        bh=bl14T+QfBvFXEIPwa57GpGJwooBP2DA+yqXwD5aTaUU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NbCG/up5s3g/ZZi52Me/fSs8mmdJnMj/ruEW8JZqajE8E0id+0ln0VRjNLNuDqYJ3
         M7R7esSbjO1jAiXW/rreBvILjvz8Tnt7YHAipn1ayqhu+zqf2mJWy3E1g67+2FEGP2
         ga6LpRCgVSEyJQzlySirFtMxf/ntcFmzwr7GIk+BSEI61EIeg67G+6NveLbC7uOTtW
         RdoY2mPwjNpqSt7//xCmflxU3Mc7vBI313J6pdBOZgbGH4aAY4WX97qT3PF9Ih1GmH
         iCTmsPMknvnUIiqcs+Pb7qxdDO3OpyxgyCwbGz/RXIJXrszP2iFrMi6WgG6lo6Qlgd
         CeKiXkwfOsD5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220505101433.1575096-2-gengcixi@gmail.com>
References: <20220505101433.1575096-1-gengcixi@gmail.com> <20220505101433.1575096-2-gengcixi@gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Cixi Geng <gengcixi@gmail.com>, baolin.wang7@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        mturquette@baylibre.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        zhang.lyra@gmail.com
Date:   Mon, 11 Jul 2022 13:27:38 -0700
User-Agent: alot/0.10
Message-Id: <20220711202740.198F4C34115@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cixi Geng (2022-05-05 03:14:30)
> From: Cixi Geng <cixi.geng1@unisoc.com>
>=20
> Add a new bindings to describe ums512 clock compatible string.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
