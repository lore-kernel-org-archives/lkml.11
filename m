Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF2CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 18:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiGHS7T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiGHS7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:59:18 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DCE1C138;
        Fri,  8 Jul 2022 11:59:15 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657306753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wj7N+bil9RLaGeoY6bi4vc0yDBSE8E8Ymrs5hXbP3dY=;
        b=HhzsD2NgWV3j8Wtf8ZDSilmZWsR+DtLpQ2OtYlu2x65RfE/gLbg0Uy/ztiFaz0YKdc8wf1
        bLh/h4AihQFihDmoX3wOoTkPxXW+oiUckLGusELd5BSoa/YU0WeeG3izkrfjLPbzt6EaIt
        TMsovi9sPGKqUl2eRdFCDmZPNXdjaWU=
Date:   Fri, 08 Jul 2022 18:59:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   oliver.upton@linux.dev
Message-ID: <dd74ef488fc56512b65039329643b72e@linux.dev>
Subject: Re: [PATCH] KVM: arm64: Use the bitmap API to allocate bitmaps
To:     "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Marc Zyngier" <maz@kernel.org>,
        "James Morse" <james.morse@arm.com>,
        "Alexandru Elisei" <alexandru.elisei@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
In-Reply-To: <a93d3e94be2003922c7e9652b57e96261cc47641.1656961792.git.christophe.jaillet@wanadoo.fr>
References: <a93d3e94be2003922c7e9652b57e96261cc47641.1656961792.git.christophe.jaillet@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

July 4, 2022 12:10 PM, "Christophe JAILLET" <christophe.jaillet@wanadoo.f=
r> wrote:=0A> Use bitmap_zalloc()/bitmap_free() instead of hand-writing t=
hem.=0A> =0A> It is less verbose and it improves the semantic.=0A> =0A> W=
hile at it, turn a bitmap_clear() into an equivalent bitmap_zero(). It is=
=0A> also less verbose.=0A> =0A> Signed-off-by: Christophe JAILLET <chris=
tophe.jaillet@wanadoo.fr>=0A=0AReviewed-by: Oliver Upton <oliver.upton@li=
nux.dev>
