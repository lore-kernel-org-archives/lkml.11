Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D79C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 15:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiETPrw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351093AbiETPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:47:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014EA2D1E1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ehVMITfWWxJmdo2ASElDh6XJDw4Fkh4XfUM62ffKTG0=; b=FFdrqF4RXRsORo3JVB01x3gNul
        1dGTnHHdMpq5uKimd9K9oaERKXzbSiChFO55EfNUxJ4pzdUk+5zQgFze5zp6SBYdyv1j5l0IGmn61
        mFqzn51lWwPu1VIvFQMq/Pc6iVSHEAADOGN2K36Tl6HemmZQhmzhyJDdNjsfcSlgKNT5XJPwhsf07
        AU8Fc2HeJg3liVWqaDbscHr58nXSyiah/wm7n2+xSnljI+MsLCItoLnKTWFJLmgsbeK2FipOLAdk1
        00386d6/mPVvNgtzbLIzhRFePwuKol8Gkf+faQbJZiwWF3qbJnYBvD+OVzrBBb3wUWEIVnjZDmEP/
        x53TrJtA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns4qq-00GdRb-9j; Fri, 20 May 2022 15:47:40 +0000
Date:   Fri, 20 May 2022 15:47:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <Yoe4HP9iTA6l/For@zeniv-ca.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
 <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:34:46AM -0600, Jens Axboe wrote:

> I'm very sure, otherwise we're just accepting that we're breaking real
> world applications.

"Breaking" as in "it used to work with earlier kernels, doesn't work with
recent ones"?  Details, please...
