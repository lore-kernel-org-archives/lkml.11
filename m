Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97AAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Feb 2022 09:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbiBBJQt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Feb 2022 04:16:49 -0500
Received: from relay040.a.hostedemail.com ([64.99.140.40]:29287 "EHLO
        relay5.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiBBJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:16:48 -0500
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id B115C120379;
        Wed,  2 Feb 2022 09:16:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 79F6320034;
        Wed,  2 Feb 2022 09:16:46 +0000 (UTC)
Message-ID: <4ee87d70d5348949787b2d747f90ecffa3119d0b.camel@perches.com>
Subject: Re: [PATCH RESEND v2] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
From:   Joe Perches <joe@perches.com>
To:     Maninder Singh <maninder1.s@samsung.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Vaneet Narang <v.narang@samsung.com>
Date:   Wed, 02 Feb 2022 01:16:45 -0800
In-Reply-To: <20220202071405.1872044-1-maninder1.s@samsung.com>
References: <CGME20220202071414epcas5p1d329ae4f76c281c1f8f7f07bfb36a919@epcas5p1.samsung.com>
         <20220202071405.1872044-1-maninder1.s@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tjwit93oqq3ib8pui69qna6ogwgq4zey
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 79F6320034
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1840uolMjefb0BuJlPMyz6gMMLS92lRSh8=
X-HE-Tag: 1643793406-276028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-02 at 12:44 +0530, Maninder Singh wrote:
> printk_deferred and printk_deferred_once requires LOGLEVEL in argument,
> but checkpatch.pl reports it as warning:

When did that occur?  Please reference the specific commit.
When printk_sched (now printk_deferred) was created it did not
allow KERN_<LEVEL>.

see commit 3ccf3e830615 ("printk/sched: Introduce special printk_sched() for those awkward moments")

There are many existing printk_deferred uses without KERN_<LEVEL>.

> WARNING: Possible unnecessary KERN_ALERT
> printk_deferred(KERN_ALERT "checking deferred\n");


