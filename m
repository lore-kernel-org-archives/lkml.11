Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1FCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 11:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiDHLDi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiDHLDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:03:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5A212AA8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:01:33 -0700 (PDT)
Received: from zn.tnic (p200300ea971561a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61a9:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14D4F1EC0528;
        Fri,  8 Apr 2022 13:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649415692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0twYPvAbU3EQQV90bdC9MeTmssNOjIsgXlwghQ9IMhQ=;
        b=mXXZTEsCZzRzxCwwF0vFXTgAC8GGvwYQSaJig1C/LGy1TtVAo/cz6WcN1ft8cHvq/eZxD7
        jMv4DT0DxnOPqHngvGa0ioCqWn3uG6W9I093fLQ/k3Gx+UYaKVnDCvAdZ9bUXT814J5FBv
        q4nFc6ZjSoqb8JB1HVaVGaRfjSLkFHw=
Date:   Fri, 8 Apr 2022 13:01:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Frank Li <Frank.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/11] perf/imx_ddr: Fix undefined behavior due to shift
 overflowing the constant
Message-ID: <YlAWC+kzv2kpCUsq@zn.tnic>
References: <20220405151517.29753-1-bp@alien8.de>
 <20220405151517.29753-10-bp@alien8.de>
 <20220408104739.GA27564@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408104739.GA27564@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:47:40AM +0100, Will Deacon wrote:
> (let me know if you'd prefer for me to queue this directly)

Yes please.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
