Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8D8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jan 2022 14:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiAXONY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:13:24 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59904 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiAXONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:13:23 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JjBlz4K4dz1r3fB;
        Mon, 24 Jan 2022 15:13:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JjBlz3MpPz1qqkC;
        Mon, 24 Jan 2022 15:13:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2ksgDqrlUy4J; Mon, 24 Jan 2022 15:13:18 +0100 (CET)
X-Auth-Info: Gyh3dmqKeEnmIGEzViLL2XXKQrVMn7AY/WYEBsXfO/cgaBONH15/ik6zgQOkwvO2
Received: from igel.home (ppp-46-244-179-110.dynamic.mnet-online.de [46.244.179.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 24 Jan 2022 15:13:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 32A102C37B9; Mon, 24 Jan 2022 15:13:18 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [RFC V1 08/31] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
        <1643029028-12710-9-git-send-email-anshuman.khandual@arm.com>
X-Yow:  Were these parsnips CORRECTLY MARINATED in TACO SAUCE?
Date:   Mon, 24 Jan 2022 15:13:18 +0100
In-Reply-To: <1643029028-12710-9-git-send-email-anshuman.khandual@arm.com>
        (Anshuman Khandual's message of "Mon, 24 Jan 2022 18:26:45 +0530")
Message-ID: <87mtjl8bnl.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 24 2022, Anshuman Khandual wrote:

> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return __pgprot(pgprot_val(PAGE_NONE_C)|_PAGE_CACHE040);

_PAGE_CACHE040 should only be present when running on a 040 or 060.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
