Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133ECC19F2C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 13:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiHCNV0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiHCNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:21:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708B5193E3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:21:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1911F37B77;
        Wed,  3 Aug 2022 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659532883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FdXtbTbAlquuEbPLJVuxdZ+BYt1g8PCyLrizW86wNz4=;
        b=KGj11myTo2pD1rq3sgsmCbuXzyVFUFNrsHMPtvFpv6jtBsFvqlpG/lPmQtBm8TmuhSQ0Dh
        E87kA5/WO7CwqhWFvTs6YiUjiB4wG1fIQoCTMULofdQfQv3OmCT0bGqwxyz8ib8NNJrldD
        QWqQpB/GE7PIrY21+kIH0Tyfolg+Ceo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA90113A94;
        Wed,  3 Aug 2022 13:21:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iKFWNlJ26mLgegAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 03 Aug 2022 13:21:22 +0000
Date:   Wed, 3 Aug 2022 15:21:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <Yup2UimZJgbgFb3S@dhcp22.suse.cz>
References: <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
 <YuolieBmdaIzoS3t@dhcp22.suse.cz>
 <Yuqs+BTpfh9/PjtP@feng-clx>
 <Yupb+1mmn9sQ/G8K@dhcp22.suse.cz>
 <Yurd2iYp4XMIYM7T@feng-clx>
 <YupwjN6K6e6V3y+Q@dhcp22.suse.cz>
 <Yurj0sOXgGf40AJE@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yurj0sOXgGf40AJE@feng-clx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-08-22 05:08:34, Feng Tang wrote:
[...]
> Do we still need the other nodemask API I proposed earlier which has
> no parameter of gfp_flag, and used for __nr_hugepages_store_common?

I would touch as little code as possible.
-- 
Michal Hocko
SUSE Labs
