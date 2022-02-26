Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 20:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiBZUVo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Feb 2022 15:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:21:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A991AF36;
        Sat, 26 Feb 2022 12:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WmtOkSWO4SOmYPlhIfufKrnjbZHD9QNJg2d3XqVXAm0=; b=ta1KYpAi54ReQLVKTz+iyYJX4r
        rW+r1l7AsJ22/OJGRcyrBAUUGXHJdCo3cVxh43DHYsIlne5Odk4tJR8BovoAisNUXd/LbBuEdlvLU
        Rq264tn4tDtsPf2KFbugEkVevc72foqNiiMDrX5y/mNtpQLOZbwUsIMpk2NYXULh//6bxYpa2Au3z
        EKJSr6Vj//G81fHZ6YnPoMtU6/hVeSODSPavM+MplwFYBfpIx2y2peEgUB/bxHq9tRfdwEfi6pSux
        EWcatI5qWpM/WOkvJQuGcZ3ejlm7N4EuPzgD/MtUZHrxD7dzkrsA7D6Bd4/bsJh5C84b19SEjSAsk
        C8cnw/ZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO3Ya-008U5D-40; Sat, 26 Feb 2022 20:20:44 +0000
Date:   Sat, 26 Feb 2022 12:20:44 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     yingelin <yingelin@huawei.com>, ebiederm@xmission.com,
        keescook@chromium.org, yzaikin@google.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zengweilin@huawei.com,
        chenjianguo3@huawei.com, nixiaoming@huawei.com,
        qiuguorui1@huawei.com, young.liuyang@huawei.com
Subject: Re: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls
 into its own file
Message-ID: <YhqLnIjopfoBEBcV@bombadil.infradead.org>
References: <20220223030318.213093-1-yingelin@huawei.com>
 <YhXwkTCwt3a4Dn9T@MiWiFi-R3L-srv>
 <c60419f8-422b-660d-8254-291182a06cbe@huawei.com>
 <Yhbu6UxoYXFtDyFk@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhbu6UxoYXFtDyFk@fedora>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 10:35:21AM +0800, Baoquan He wrote:
> That seems to be an issue everything related to sysctl are all added to
> kernel/sysctl.c. Do you have a pointer that someone complained about it
> and people agree to scatter them into their own component code?

https://lkml.kernel.org/r/20220226031054.47DF8C340E7@smtp.kernel.org

> I understand your concern now, I am personally not confused by that
> maybe because I haven't got stuff adding or changing into sysctls. My
> concern is if we only care and move kexec knob, or we have plan to try
> to move all of them. If there's some background information or
> discussion with a link, that would be helpful.

We're moving them all out. Sorry, yingelin's commit log message sucks
and it needs to be fixed to account for the justification. All the
filesystem sysctls are already moved out. Slowly we are moving the other
ones out and also doing minor optimizations along the way.

  Luis
