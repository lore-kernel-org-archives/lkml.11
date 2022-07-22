Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1FAC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 01:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiGVBmv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVBmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E9820F8;
        Thu, 21 Jul 2022 18:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E952461FA2;
        Fri, 22 Jul 2022 01:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC4BC3411E;
        Fri, 22 Jul 2022 01:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658454168;
        bh=PUyBpsVmRXM3a3LLiAPSq+ZaOk7fRfAc8f9l84o/C3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cc5ACvakfQDV3FQLxCSYnR5n8pzEywRpm6MUk+ytF0Nr7UlVB4/mjhtE1COsKyY5D
         4uYjaoqyFkMAEO5POyPIVNRcxQqX26hAJPcgzgUlnGE6L9QFnbXKxLJmzwieJ66rGL
         Qq2Q4RRlw5etTIoJjYH7LudbkKZd4snlaqxWnw8qClOT7qhQK0eAWLsZ1DzfWCYXFc
         Nh4qGSH05iq+mDbfIKC7a2SQSk9Z5xsLcAdzFjkDtLnJbaL2wV/C2N5gdu1rTtn9pH
         YZL//xNhdGiw+/98IE8JhEi/VnrRhTvm2uFkRX79GT+alNn0BVTVXZf9EoEcEsrKSE
         YTUcB9zl5Wvtg==
Date:   Thu, 21 Jul 2022 18:42:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chunhao Lin <hau@realtek.com>
Cc:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add support for rtl8168h(revid 0x2a) +
 rtl8211fs fiber application
Message-ID: <20220721184243.31ace75f@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20220721144550.4405-1-hau@realtek.com>
References: <20220721144550.4405-1-hau@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 22:45:50 +0800 Chunhao Lin wrote:
> rtl8168h(revid 0x2a) + rtl8211fs is for fiber related application.
> rtl8168h will control rtl8211fs via its eeprom or gpo pins.
> Fiber module will be connected to rtl8211fs. The link speed between
> rtl8168h and rtl8211fs is decied by fiber module.

Compiler says:

drivers/net/ethernet/realtek/r8169_main.c:614:24: warning: symbol 'rtl_sfp_if_eeprom_mask' was not declared. Should it be static?
drivers/net/ethernet/realtek/r8169_main.c:617:24: warning: symbol 'rtl_sfp_if_gpo_mask' was not declared. Should it be static?
