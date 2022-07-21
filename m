Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47BBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiGUPWn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:22:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635381FCE3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=18IhroUGeHEx3M1LazyEz3WKWJiZ0ox5uDr8Q7r9CWs=; b=Otxg257FRhjTZXr/F9G32USeeU
        YO6rDzZYNOwkDC2Hw+ye13Fq0mVPzmkLT/qDrdTJDq2S1AucVRI4b4ogvxl9bkkldRLS7+ibiK1Ec
        MzpY6HITq3D8C9B4gatb2M/wmT84it5/0AKN8WDHqzjlKjCBsStuRCwZXn4o8gnfojrLBDqlGZKfb
        6y5SGdg6ofkOP6q0NW1J8HNlL9ERpZoyFaUpYPTYvuWrgmy96eIdcNMoELZuYCynuEBgr3ju70Aim
        klQFejTFVipdAwwDe2QK4y8HPPOxWjJ7c2qkJJxi44xsp15enBd081XWpyF9UAdAXv3DOz7A9Wys8
        bAzYSOlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEY0d-0090jY-1C; Thu, 21 Jul 2022 15:22:39 +0000
Date:   Thu, 21 Jul 2022 08:22:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben-linux@fluff.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: make arch_get_kallsym() static
Message-ID: <YtlvP1toPTmv4brF@infradead.org>
References: <20220721151040.359389-1-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721151040.359389-1-ben-linux@fluff.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 04:10:40PM +0100, Ben Dooks wrote:
> The arch_get_kallsym() function is not used anywhere in the kernel
> now, so it should at-least be static or just be removed as there
> are no users. Making it static fixes the following sparse warning:
> 
> kernel/kallsyms.c:590:12: warning: symbol 'arch_get_kallsym' was not declared. Should it be static?

It fixes the warning, but isn't exactly useful.  Please just remove it,
get_ksymbol_arch and iter->pos_arch_end entirely instead.
