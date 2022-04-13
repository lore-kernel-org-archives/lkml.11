Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51349C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 16:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiDMQme (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiDMQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:42:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9257337AAE;
        Wed, 13 Apr 2022 09:40:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B12B268AFE; Wed, 13 Apr 2022 18:40:03 +0200 (CEST)
Date:   Wed, 13 Apr 2022 18:40:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        hch@lst.de, yangtiezhu@loongson.cn, amit.kachhap@arm.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 RESEND 1/3] vmcore: Convert copy_oldmem_page() to
 take an iov_iter
Message-ID: <20220413164003.GA31487@lst.de>
References: <20220408090636.560886-1-bhe@redhat.com> <20220408090636.560886-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408090636.560886-2-bhe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
