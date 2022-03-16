Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 22:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354317AbiCPWCG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 18:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiCPWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:02:04 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB3C2C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:00:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8A4596081104;
        Wed, 16 Mar 2022 23:00:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oErL0m0ft9MT; Wed, 16 Mar 2022 23:00:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27A666081107;
        Wed, 16 Mar 2022 23:00:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bASUU7w2xFjh; Wed, 16 Mar 2022 23:00:48 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EC3476081104;
        Wed, 16 Mar 2022 23:00:47 +0100 (CET)
Date:   Wed, 16 Mar 2022 23:00:47 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     libaokun <libaokun1@huawei.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>
Message-ID: <936195660.152787.1647468047915.JavaMail.zimbra@nod.at>
In-Reply-To: <c0d05cca-2827-481c-f534-d4fb30b91533@huawei.com>
References: <20220114102854.3399585-1-libaokun1@huawei.com> <c0d05cca-2827-481c-f534-d4fb30b91533@huawei.com>
Subject: Re: [PATCH -next v3 0/2] jffs2: fix two memory leak when mount
 jffs2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: fix two memory leak when mount jffs2
Thread-Index: a1UdSK/5tz20GyVR92v+jYiFFKkqVQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "libaokun" <libaokun1@huawei.com>
> An: "richard" <richard@nod.at>, "David Woodhouse" <dwmw2@infradead.org>, "linux-mtd" <linux-mtd@lists.infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "yukuai3" <yukuai3@huawei.com>, "libaokun" <libaokun1@huawei.com>
> Gesendet: Donnerstag, 10. März 2022 09:34:35
> Betreff: Re: [PATCH -next v3 0/2] jffs2: fix two memory leak when mount jffs2

> A gentle ping, sorry for the noise.

Patches applied.
Thanks for fixing!

Thanks,
//richard
