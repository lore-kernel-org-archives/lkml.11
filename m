Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD6C00144
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 01:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiHBBPX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 21:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiHBBPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:15:13 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77523C14
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659402909;
        bh=tAumF/NJz2IyfqS8SnDKwWnb2pe+/WlR4W2uaAgaVoM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ftaANTyCW4q9eeL5t4IM8eoFmqnxFlewYdX4Atv/2jUkaSkT0Iwx9fgaSZULTh2YI
         91GbXgkHnMtgxZWD74zTU/um+T8XQiaj9HJDnKMCmnDfLdH0a9Obv4SMZq8Ras6Xoq
         OM+xjHY6gXN9jwiK9DBnIssXMOacMgyzFFZe9Sd0=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id C6205668F0;
        Mon,  1 Aug 2022 21:15:07 -0400 (EDT)
Message-ID: <4236c3ec4bc02653965a637da5e75d399de8a9bc.camel@xry111.site>
Subject: Re: [PATCH 0/4] LoongArch: Add unwinder support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Qing Zhang <zhangqing@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Tue, 02 Aug 2022 09:15:05 +0800
In-Reply-To: <CAAhV-H61DOGHXeVmZif7e04jpYBZNja-wPyLFhAtECZkZSQScA@mail.gmail.com>
References: <20220801121726.9681-1-zhangqing@loongson.cn>
         <CAAhV-H61DOGHXeVmZif7e04jpYBZNja-wPyLFhAtECZkZSQScA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-01 at 23:34 +0800, Huacai Chen wrote:
> Hi, Qing,
>=20
> I think we don't need to CC linux-kernel; on the other hand, CC
> linux-arch and Arnd is worthy.
> BTW, it seems you are missing V2 in the title.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sele=
ct-the-recipients-for-your-patch:
"linux-kernel@vger.kernel.org should be used by default for all
patches".

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
