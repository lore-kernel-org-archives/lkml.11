Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF83C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiGOSZh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 14:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:25:36 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B0675B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:25:35 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:47016)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oCQ0N-00GNfN-14; Fri, 15 Jul 2022 12:25:35 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47774 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oCQ0M-00C0xe-4w; Fri, 15 Jul 2022 12:25:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
References: <20220713155405.80663-1-ubizjak@gmail.com>
Date:   Fri, 15 Jul 2022 13:25:27 -0500
In-Reply-To: <20220713155405.80663-1-ubizjak@gmail.com> (Uros Bizjak's message
        of "Wed, 13 Jul 2022 17:54:03 +0200")
Message-ID: <87ilnyz10o.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oCQ0M-00C0xe-4w;;;mid=<87ilnyz10o.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+c8LVUlqZsyYj+hQijEsgfPB7eQK9MRD8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/2] ucount: Fix and improve atomic_long_inc_below
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uros Bizjak <ubizjak@gmail.com> writes:

> The series fixes wrong argument type and improves atomic_long_inc_below
> by using atomic_long_try_cmpxchg instead of atomic_long_cmpxchg.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>

The bug fix at least looks correct.  I haven't reviewed the
atomic_long_try_cmpxchg yet.

Thanks,
Eric


>
> Uros Bizjak (2):
>   ucount: Fix atomic_long_inc_below argument type
>   ucount: Use atomic_long_try_cmpxchg in atomic_long_inc_below
>
>  kernel/ucount.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
