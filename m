Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77233CCA473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 20:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiFXUQ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 16:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFXUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:16:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B7F7C840;
        Fri, 24 Jun 2022 13:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D8CAB82B97;
        Fri, 24 Jun 2022 20:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04747C34114;
        Fri, 24 Jun 2022 20:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656101812;
        bh=4QRUtnLSzmrMQQ9qX22jJ4l+dPRlwBTscT5+qfKgSD8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gkJ8T59vdML4M8M5BzskJhOxZRZvGe3BrktXTIpvBQ7Gn0TGH5CjOCDF2r+5i7nF6
         fU0CFPd+uWOnALRg0FQAU8P25cbkfKBSmExAzEzmo6iVp/AJSwmkyPEcc7BaOv3Dlr
         wrvTP0tbGsBKQ2Bjw9GdmodnnwmQaMNOnsxsUIIHKgCkd2oj6VPYGH4y58SRxjE47w
         T1AMJVUeBFiabLuaD0duj4yKRdghVwnfMQ/HKtpVCVCrez0ygD8Y2GLiRV5nK+Ainc
         pKe/ej4fi/7MaH0QOFigrLcmfzbcCaYePgQKUvLaZsXbaTa9J2X6NrsiUHWDfwlYtw
         paiWjDn4+V0sw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YrXo+i3wwl2ERKIj@xps13>
References: <20220623142837.3140680-1-bmasney@redhat.com> <20220624002055.58BCFC341C0@smtp.kernel.org> <YrXo+i3wwl2ERKIj@xps13>
Subject: Re: [PATCH] clk: qcom: sc8280xp: add parent to gcc_ufs_phy_axi_clk for sa8540p
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
To:     Brian Masney <bmasney@redhat.com>
Date:   Fri, 24 Jun 2022 13:16:49 -0700
User-Agent: alot/0.10
Message-Id: <20220624201652.04747C34114@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2022-06-24 09:40:26)
> On Thu, Jun 23, 2022 at 05:20:53PM -0700, Stephen Boyd wrote:
> > Quoting Brian Masney (2022-06-23 07:28:37)
> > > diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-s=
c8280xp.c
> > > index 4b894442fdf5..4639b50da418 100644
> > > --- a/drivers/clk/qcom/gcc-sc8280xp.c
> > > +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> > > @@ -5696,6 +5709,7 @@ static struct clk_branch gcc_ufs_phy_axi_clk =
=3D {
> > >                 .hw.init =3D &(const struct clk_init_data) {
> > >                         .name =3D "gcc_ufs_phy_axi_clk",
> > >                         .parent_hws =3D (const struct clk_hw*[]){
> > > +                               &gcc_ufs_ref_clkref_clk.clkr.hw,
> > >                                 &gcc_ufs_phy_axi_clk_src.clkr.hw,
> > >                         },
> > >                         .num_parents =3D 1,
> >=20
> > num_parents needs an update.=20
>=20
> Oops!
>=20
> > But this is a branch, not a mux, so it can't have more than one
> > parent.
>=20
> Would a mux be represented with 'struct clk_rcg2'?
>=20

Could be. An RCG is more than a mux, because it also has a divider and
an m/n counter.
