Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4948C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Jul 2022 04:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiGBEYN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Jul 2022 00:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGBEYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 00:24:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF827CF7;
        Fri,  1 Jul 2022 21:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D0260C32;
        Sat,  2 Jul 2022 04:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9A0C341C7;
        Sat,  2 Jul 2022 04:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656735844;
        bh=0JxhHAplfI63oB/NzCnRqg7Nzu+/8/KjAvBoeKJIaJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X2UjaxB7lVcvMqDmSNFUBUuvl8wh3eEfB1LTc9Z9xTkwQMSqHY4js3IBGTpNNcYoL
         m1/60T5cdPbZRoW8JkGhbbeo5i8clmn65j1+qMCZnq1sIpDs3dXCKVdFNZhgorIDpq
         etEsUljuPoIoFHxAE7ZaLMsjLcLQ68CbmcnPajL8=
Date:   Fri, 1 Jul 2022 21:24:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     willy@infradead.org, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        21cnbao@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        david@redhat.com, ebiederm@xmission.com, hagen@jauu.net,
        jack@suse.cz, keescook@chromium.org, kirill@shutemov.name,
        kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, longpeng2@huawei.com, luto@kernel.org,
        markhemm@googlemail.com, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de, surenb@google.com,
        tst@schoebel-theuer.de, yzaikin@google.com
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
Message-Id: <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
In-Reply-To: <cover.1656531090.git.khalid.aziz@oracle.com>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 16:53:51 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:

> This patch series implements a mechanism in kernel to allow
> userspace processes to opt into sharing PTEs. It adds a new
> in-memory filesystem - msharefs. 

Dumb question: why do we need a new filesystem for this?  Is it not
feasible to permit PTE sharing for mmaps of tmpfs/xfs/ext4/etc files?
