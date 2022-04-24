Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C65C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Apr 2022 15:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiDXPhM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Apr 2022 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbiDXP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:28:45 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502C3186F0;
        Sun, 24 Apr 2022 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SSwEb
        R1Q0zSkY2pkp2ZsB1ndiNG5yqAkeTuM/roPQF8=; b=hPyVegbjX0JylMYh/e+HX
        IS+ahqmgjqBBm3IzNIva1SPiyQvhX/4uvc5lC8MeFzN4p5beKIW23HqerLPeB6oE
        6gtvtrZFCsjBx1ss/mPNFAxzBa+RkwO0/NLdv6sM+RYMIHsGidfaoV3L5w+m9HBO
        6a8Cv0TKCzZ1OULa4sgnks=
Received: from localhost (unknown [113.116.51.137])
        by smtp12 (Coremail) with SMTP id EMCowAC3kXW4a2ViEoBPBQ--.1532S2;
        Sun, 24 Apr 2022 23:24:41 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     willy@infradead.org, Junwen Wu <wudaemon@163.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, ddiss@suse.de,
        fweimer@redhat.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] proc: limit schedstate node write operation
Date:   Sun, 24 Apr 2022 15:23:54 +0000
Message-ID: <YmNs+i/unWKvj4Kx@casper.infradead.org> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423023104.153004-1-wudaemon@163.com>
References: <YmNs+i/unWKvj4Kx@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAC3kXW4a2ViEoBPBQ--.1532S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRJ8neDUUUU
X-Originating-IP: [113.116.51.137]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBFArrbVaEDhGxwgABsn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20220424152354.YvP810z4DjdXxXspWzCdwUz-SQHILZydxFs4QMGuHqI@z>

From: Matthew Wilcox <willy@infradead.org>

On Sat, Apr 23, 2022 at 02:31:04AM +0000, Junwen Wu wrote:
> Whatever value is written to /proc/$pid/sched, a task's schedstate data
> will reset.In some cases, schedstate will drop by accident. We restrict
> writing a certain value to this node before the data is reset.

... and break the existing scripts which expect the current behaviour.


Hi, Matthew,can you describe it in more detail.

Thanks

