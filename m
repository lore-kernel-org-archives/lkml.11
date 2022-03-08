Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0361C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiCHNyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiCHNyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:54:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C604A4993A;
        Tue,  8 Mar 2022 05:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UxFyjf8fIjK3VBfSpCLEL1uzZW2yqy/7Thuvw60iGfw=; b=Qe3i1pm7WH2ymayd3hoB9Z/mEA
        vnyKwJ9g0cDoANQoUjysMgQG/r8MieR2hy3E4Ky+pohLGMEhgpY4MOdrihrWm80eyORZLCj+hZPny
        1C0wOZwosfgVV59MEH25/Bxyji9BDIpSYBq14MbgvFe2HeKTnhl5JhROPlQs4zARfzeQp32sLnOZb
        DL0wju4dtc1+bjHLIbUNMTFB/5MuJcphPNTjWnZdBz9tJ6Hpu2lN/WaxpC108pui5IZQa5jF3gHPb
        YMHHNMpbMSwyNWspAwz6JdN+CLUlxNUOPFj3G1FY9WZ8wUFU1fBwMy8GNO12sKJeWlFhD8tw4ed3O
        dXlV/x/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRaHM-00GDH2-AN; Tue, 08 Mar 2022 13:53:32 +0000
Date:   Tue, 8 Mar 2022 13:53:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Salih MSA <salihmahmoudsahmed@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org,
        Salih MSA <salih.msa@outlook.com>
Subject: Re: [PATCH] fs: aio: fixed purely styling errors
Message-ID: <Yidf3D2FqavJawp+@casper.infradead.org>
References: <20220307082257.582466-1-salih.msa@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307082257.582466-1-salih.msa@outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:22:57AM +0000, Salih MSA wrote:
> Mostly clarified unsigned -> unsigned int.
> Also separated declarations from functionality.

Please don't.  Why did you think this patch would be a good idea?
What could we write somewhere that would have dissuaded you from sending
this patch?
