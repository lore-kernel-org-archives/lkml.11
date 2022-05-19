Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC8AC4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 23:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbiESXQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiESXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23642590A9;
        Thu, 19 May 2022 16:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A83766187F;
        Thu, 19 May 2022 23:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083A1C385AA;
        Thu, 19 May 2022 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653002173;
        bh=4RcOsbOkSH2T6G+z2bll0695ifRPLbDDEza7W0mHcq4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A0us1n3t0rCnFXtfd/1Gs0VKNNwEHOoEeF8dRVZCCBEEaX42us69vpmVCyUlrVD/c
         2RmdHKmySO/GZirxNjQusIwRpDnpvv469UP8gBPbDQkkWRyIogLKHGwiWGeTMj8g8i
         2WNOp7bM3MfVvmzGLYrvi29RVJDvjn/cpN90znkj7pEs8Dgw9+FzET/EB8X7ldhieG
         GNLnngMiT7nZprvnEMpUUXGrWUAal2jpjJW2kfxVdmlb01s9fcTgESsNHNiWxR8r7e
         zn468IsI3OUn2xfPCaMZj5i7VIUQX/LGC78PfvukTLSmfMftU7aJLsDU3KINjbIVGf
         sQZGUI1asCcFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220428154154.2284317-1-robh@kernel.org>
References: <20220428154154.2284317-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Replace common binding with link to schema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
Date:   Thu, 19 May 2022 16:16:11 -0700
User-Agent: alot/0.10
Message-Id: <20220519231613.083A1C385AA@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2022-04-28 08:41:54)
> The contents of the clock binding have been moved to the clock binding
> schema in the dtschema repository. The desire is for common bindings to
> be hosted in the dtschema repository.
>=20
> Replace the contents with a link to the clock binding schema as there
> are still many references to clock-bindings.txt in the tree. This will
> prevent additions without a schema.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

> Most of the clock binding doc was already moved. 2 more sections are
> pending:
>=20
> https://lore.kernel.org/all/20220428152633.2261979-1-robh@kernel.org/
> https://lore.kernel.org/all/20220428152719.2263164-1-robh@kernel.org/

I missed this one!
