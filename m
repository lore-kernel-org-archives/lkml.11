Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848FAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 04:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiFHENf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 00:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiFHEM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:12:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCB2C27A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZiiNVv1tsif5Skk/rMx0RbSaOoKZ/KEqXdjHzDtjcl4=; b=Kt0reQOMTVsjBwMDwNBr2d2PjM
        7BB0VU7n8pDfyVpukyn70Op70Y3anUi3qGkIWGKHIDRo0S8srs7pkxWkAe9VcaCSISx6YKUA20Tfw
        2acgC74T9tznoB3jaYwdoyEg7bS32VLPXUlQF4CYmRfW+8Vo0DXURygLourNgpHOvYaOL9tqqQ6WS
        YPG1qHvR6oOPZ1VUm9a3NCTnGdOYXNfRRqFmZJWQyi0/qTqZ8e6BhaXRi3BBorqDVBXoaDlAQEx7m
        yvUzDv5PQt31xF9lNA5vDWWw9eJkr6fZkvXkTzNHg9Eo+BmXMuwqp1oN1AXaDtFsU2KnhvgMJiM36
        k8qda2Qg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nykXv-00CCL5-PU; Wed, 08 Jun 2022 01:31:43 +0000
Date:   Wed, 8 Jun 2022 02:31:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     XU pengfei <xupengfei@nfschina.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kernel@nfschina.com
Subject: Re: [PATCH] mm: Add blank line to make the layout of the program
 clearer
Message-ID: <Yp/7/9pCVQC9ovGT@casper.infradead.org>
References: <20220608012233.6433-1-xupengfei@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608012233.6433-1-xupengfei@nfschina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:22:33AM +0800, XU pengfei wrote:
> Add blank line to make the layout of the program clearer

I've seen some terrible ideas for inflating patch counts, but
this is just ... no.
