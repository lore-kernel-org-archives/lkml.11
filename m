Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7968C25B0C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 08:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiHKItr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiHKItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:49:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD53915D6;
        Thu, 11 Aug 2022 01:49:45 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:9ab1:e492:a665:9f6a] (unknown [IPv6:2a00:23c6:c311:3401:9ab1:e492:a665:9f6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B9CC96601C9A;
        Thu, 11 Aug 2022 09:49:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660207783;
        bh=I+1tQ7yLOIL7esXvT/4v4IrIlYrx7s7m1Jb9IB00p5A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X72gDGmZgDzzc9cZQJlviGe5qrBkGCwG2w60qrlcKDNznKHPwr8Sibw43l5TKE6Ep
         KauBO9xMIcp739eEAp6cNlqhgbxaFmf71nUCSdTkLPOkRc+3fSV5qxuo+sjQnJFwng
         +0zgOoduqX0P2lqM+y0V9QJItdCvvUVFBbrvt3P+Swa1+BreJ0TYvKDEm45a8guILJ
         qvhSjnumSLdramPrzYvTSpiqfWZfIHLlzCbgdMuk9M6mFec0ieuTPW4zL9zf2TS8xL
         VjnPLywqluV2wK2c0TyNkizKrTNqv9pjXhtB7MEsBDRLfHPeZkc41yVAwBdVaRvVvO
         u1C6bChwBg2TQ==
Message-ID: <5d2aacb5b0a06a4ad63fe28f4b34e4fb41f955f5.camel@collabora.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mp-msc-sm2s: Add device trees
 for MSC SM2S-IMX8PLUS SoM and carrier board
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 11 Aug 2022 09:49:40 +0100
In-Reply-To: <eade56c1-bf4e-0ece-9b67-02f01a95c741@linaro.org>
References: <20220721101050.2362811-1-martyn.welch@collabora.com>
         <20220721101050.2362811-2-martyn.welch@collabora.com>
         <eade56c1-bf4e-0ece-9b67-02f01a95c741@linaro.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-21 at 18:34 +0200, Krzysztof Kozlowski wrote:
> On 21/07/2022 12:10, Martyn Welch wrote:
> > Add device trees for one of a number of MSC's (parent company,
> > Avnet)
> > variants of the SM2S-IMX8PLUS system on module along with the
> > compatible
> > SM2S-SK-AL-EP1 carrier board. As the name suggests, this family of
> > SoMs use
> > the NXP i.MX8MP SoC and provide the SMARC module interface.
> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > ---
>=20

Is there anything else I need to do to get this ready for inclusion?

Martyn

>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
>=20
> Best regards,
> Krzysztof

