Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D92C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 08:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiCYICv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiCYICn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:02:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0DACA0FF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DwcbPzTVDRib4L1VsoxgMlldaVEStIsqmgFfJT2ZVEs=; b=0InZFbogVnMbo7ICwYkHgA7+6k
        E8aa3tNj3Cg9SHcU3vU7bszlSErTUNqErsQkEtr8YWm6i+ufRv5Z7P4LcmTb0Rii9N8IEcHwpyU4K
        /ptmmp5IzKuBJmlwusocdTz3zsc1tWZN0L0TlfXvoeECIRCqtCDp+co4Qs4zjEibqfusrPq1QwUfh
        l0Mx9eOQK4hNTVw5MrqeEkztc8M7j1fzEtrX0pNb7gCmpzw2bRGYf4phJUrAL+x5lmHAwDNu/0X/E
        At8SmvuppNYi57yNH5cJphnkPT6Eluy3uofIRr/sSi3m9wbFAXb7kUaS1fOAFEww7+qQWGDYzfACv
        KmAKCT3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXesY-001OG5-Qz; Fri, 25 Mar 2022 08:01:02 +0000
Date:   Fri, 25 Mar 2022 01:01:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oh Eomji <eomji.oh@samsung.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: Re: [PATCH v1 1/3] sound: usb: Add vendor's hooking interface
Message-ID: <Yj12vorW0FW8S6Sm@infradead.org>
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
 <CGME20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b@epcas2p4.samsung.com>
 <1648109444-196321-2-git-send-email-eomji.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648109444-196321-2-git-send-email-eomji.oh@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Independ of the actual usefulness of thi: vendor is a reallly bogus
naming choice for device specific hooks.  No one cares what vendor
produces a given device, it is all about the interface of it.  One
vendor might have different interfaces over time, from different
divisons or thrugh acquisitions, and multiple vendors can agree to
a single interface through open standards or IP licensing.
