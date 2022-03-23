Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B0BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 22:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbiCWWTd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiCWWTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:19:31 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEBB8FE5A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:17:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E3FC66081114;
        Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4-FDGu-sgWod; Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 949586081100;
        Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hVRzrM2FeVZm; Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 70D0E605DEA9;
        Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Date:   Wed, 23 Mar 2022 23:17:56 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>
Message-ID: <1214200498.178206.1648073876352.JavaMail.zimbra@nod.at>
In-Reply-To: <20220324085653.4c4c5315@canb.auug.org.au>
References: <20220315205259.71b4238a@canb.auug.org.au> <20220324085653.4c4c5315@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the folio tree with the ubifs-fixes
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: manual merge of the folio tree with the ubifs-fixes tree
Thread-Index: +v3+gZWbrfis+eeRRMLR6nh7swB4Kw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> This is now a conflict between the ubifs-fixes tree and Linus' tree.

Thanks for letting me know, I'll note this in my PR to Linus.

Thanks,
//richard
