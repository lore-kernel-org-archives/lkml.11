Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE60BC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 03:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiDWDIk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 23:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiDWDIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:08:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F8E4B;
        Fri, 22 Apr 2022 20:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SxQi15J/S+m7GUVDTi1JQZIeFqsLLWQuUAEkCr4fpr0=; b=JfuO39DnJIvtdTBrO8b1kB7hWJ
        UyHWEcNq2XEKydIC8o31W4QfkrZmYTLJoM/PeeMXAHmbr4FI39u87nAEHE91J5KuyvjH5r1jssYyn
        bKI0X3DDf7nvRoeWmRbbdaHfIzm1kClBBVuio8U3hfhQWnNbuc+X4IYIwiCF6W/qVwVQhtCRPGyqE
        yj2TH/MPjJLDNt5u/7ZKqG/TMzFofvxXMPBty+ChmVxDu5IXB39cYAgKj47aq/K3KHnYQtyIfacPW
        9diNSl5ba6pjjbCSPx1ohzPlmXtiq79SE28x0iCfDSfBjLAfsfddyOLOLDLvjNjIwsx1AeGUXqTXI
        UsqJoqbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ni65S-006f4j-Hf; Sat, 23 Apr 2022 03:05:30 +0000
Date:   Sat, 23 Apr 2022 04:05:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Junwen Wu <wudaemon@163.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        adobriyan@gmail.com, fweimer@redhat.com, ddiss@suse.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] proc: limit schedstate node write operation
Message-ID: <YmNs+i/unWKvj4Kx@casper.infradead.org>
References: <20220423023104.153004-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423023104.153004-1-wudaemon@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 02:31:04AM +0000, Junwen Wu wrote:
> Whatever value is written to /proc/$pid/sched, a task's schedstate data
> will reset.In some cases, schedstate will drop by accident. We restrict
> writing a certain value to this node before the data is reset.

... and break the existing scripts which expect the current behaviour.
