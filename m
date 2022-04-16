Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF1C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 06:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiDPGIJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 02:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPGIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:08:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D817865404
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 23:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+t0Bu8KSg3jBujgghxzlFf0uKoDQfWljvnbuJuxey94=; b=NADL9qThPsf2tQw9wSHR9J87h6
        TY536TR9jkne0wei9WY4j7IwwHfhpH1iteQfDtfp4OZtWhkNUzwPVqifBfszMOendhZl2f4xZ2u+y
        TYC00bS1du/ddF5g5gu8CKTOXCDS5Guevew6Pjc26q9dR7Z9M0Tzye5DzR1ltSKBqF7cgb7+GOLnS
        ZH9JNk7WKDNl5rub16At6nBeAgYi3wqX2ljSIa64BwQEYdkcsrW4z1OpISFIXlqvsgSU2MCZUI/+1
        dK+0Mrtad1Cvt7l6kF+NqECSoae/PgeDBD+5SorOBUGeEhESw974b1TzM4gfXqvz3hnfnTZbcEEfi
        YwNHI30A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfbYm-00CJyx-V4; Sat, 16 Apr 2022 06:05:28 +0000
Date:   Fri, 15 Apr 2022 23:05:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: Re: [RFC PATCH 4/6] virtio: Various updates to xen-virtio DMA ops
 layer
Message-ID: <YlpcqOUK59yExXlq@infradead.org>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-5-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649963973-22879-5-git-send-email-olekstysh@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:19:31PM +0300, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Various updates is a big indicator that the patch should be split
further.  Please do one change at a time, and fold updates to the
previous patches in the series into those patches instead of fixing
them up later.
