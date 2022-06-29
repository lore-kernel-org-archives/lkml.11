Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0761EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 06:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiF2GzH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiF2GzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:55:05 -0400
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E6B2A247;
        Tue, 28 Jun 2022 23:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656485700; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BtnwncbgujS3HoYF6724sSxAKbkq170OqTswxLdK+N7WhmlsaY0f1bk/mgcMbgXklKQgpe48Nc/xMHTHi19Rv879BBPINKZiqidTAgXRm9evZD+mrCTjRLx60pJyqkqra/fLid04st6wMdgFvbyKrRgveYa3UXuNsiPF7t90GAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656485700; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=zx7J9t5hS9B5cM8Wmuhp/jjmU49a0bYP74AaUQ/I8w0=; 
        b=KemcD6+2X1azXBkoLKGwbEpB7ZXdpnIHD5Yji7V7Dk9fTQmO4ra0gR9VfAu8L9J4BGEik+isQUbXANevIIzbGalLgG428eRM8S9pAzG1jygDyyDdhdt/dUN+mjPaWXYFtR/sURgLptiYj0GvrD5i6Rz8kEAeFITjzTx0PS0Oxb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=gvisoc.com;
        spf=pass  smtp.mailfrom=gabriel@gvisoc.com;
        dmarc=pass header.from=<gabriel@gvisoc.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656485700;
        s=zoho; d=gvisoc.com; i=gabriel@gvisoc.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=zx7J9t5hS9B5cM8Wmuhp/jjmU49a0bYP74AaUQ/I8w0=;
        b=XG38qm73cgRhaZuiJ3knmKWASrctY1YD2fXoGMP0ajLDE6SWstcR5mSMmxYPjeK9
        OMKjqp3CTSuDnuRAuMQq5sKgjyQwgWbf/HBP6dx6zvfkUWFsYLl1c8vKvij5UXgfbH0
        G+TrxNfKlHZwB2Mev/wtw4Kb7Y0iwLpsKCDXj/3M=
Received: from localhost (61-68-176-95.tpgi.com.au [61.68.176.95]) by mx.zohomail.com
        with SMTPS id 1656485699266117.46847988987656; Tue, 28 Jun 2022 23:54:59 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:54:53 +1000
From:   Gabriel Viso Carrera <gabriel@gvisoc.com>
To:     Joe Perches <joe@perches.com>
Cc:     andreas.noever@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: Thunderbolt: ctl.c: Fixed comment coding
 style issues
Message-ID: <Yrv3PTCgzZGu3l8j@vao>
References: <20220625084913.603556-1-gabriel@gvisoc.com>
 <20220625084913.603556-4-gabriel@gvisoc.com>
 <1a35d3bdf6adde4f21e7c1401f3a2aba64367eb0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a35d3bdf6adde4f21e7c1401f3a2aba64367eb0.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 02:37:54AM -0700, Joe Perches wrote:
[]
> 
> I'd indent this only 1 level and put it before the call
> (and fix the loose/lose typo)
> 
> {
> 	/* We ignore failures during stop.
> 	 * All rx packets are referenced from ctl->rx_packets,
> 	 * so we do not lose them.
> 	 */
> 	tb_ring_rx(pkg->ctl->rx, &pkg->frame);
> }
> 

Fair enough. Not sure on how to proceed, as these were my 
first patches ever sent, and I don't want to make anyone 
work more than the strictly necessary. 

- Should I submit an additional patch intended to be applied 
on top of 3/3?
- Should I sumbit a whole new 3/3, addressing the whole comment
issues all at once?
- Should I just wait on the outcome and proceed from there?

Advice would be appreciated.

Anyway, I will be sending some patches over other files for 
the time being, paying more attention to the details.

Thanks,
~Gabriel
