Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB53BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 20:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354730AbiDZUQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbiDZUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:16:40 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D0C187B61
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wma5qGl6m0DLICkK7OP23+WAeNsi/jPPc46lYaJH56Y=; b=G5EWZFxZSPo4mQMq7QaYAzdmC8
        RhHw7VC1l7yUY3zXOEKxOwoQDqH8g1TvbqsY09BAkgsZYSI1jlxPocy7JD1lcBF4/NSMKi5KvmYpp
        Afvz70JD3iLIUY8Ec2Fi3Pe5RaQ2Q2TQByQhbW4e1vhu/by4GeaF34lFhFPyJeJy5ARXOW5wuDHDr
        MtvDUZa1MZXs+vB726qNbXGIVjUt2dVAbfcP1Gs0XzWSj2wLxtbOWnR6hh8U8hSV+BLtOh15rYiWZ
        LyAPRUKOoylPrB3G6XU9LZksz2b+yQM8YSH91axQvmbVntcNTwz72Jx9XOW3IYKP3qZNy4su9mpph
        CI/2dDLQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njRYo-009iwL-6x; Tue, 26 Apr 2022 20:13:22 +0000
Date:   Tue, 26 Apr 2022 20:13:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/10] kernfs: Remove reference counting for
 kernfs_open_node.
Message-ID: <YmhSYkXp0KBXOyFc@zeniv-ca.linux.org.uk>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-2-imran.f.khan@oracle.com>
 <YmLRxWUnF/zflEO2@slm.duckdns.org>
 <e30f95c3-ab55-bb1b-75c1-8bd2f91787b5@oracle.com>
 <Ymg6AazfnwdZXkXx@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymg6AazfnwdZXkXx@slm.duckdns.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:29:21AM -1000, Tejun Heo wrote:

> The code is just wrong. You can end up:
> 
>         on = kn->attr.open;
>         if (!on)
>                 return;
> 
>         // we get preempted here and someone else puts @on and then
>         // recreates it

Can't happen - the caller has guaranteed that no new openers will be
coming.  Look at the call chain of kernfs_drain_open_files()...


Al, back to life and staring at the pile of mail to sift through...
