Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997B1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 07:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiEQHiX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241583AbiEQHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:36:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727048889;
        Tue, 17 May 2022 00:36:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A34C1FBB6;
        Tue, 17 May 2022 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652773016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5k0bGOWkmGL1ogvQ/PreqJMh1U1K6c4WBr2eA6nTSAM=;
        b=k1hgAxLHcPwk3vEQCWus51vT4+BvTaLYR+QHOAK3xVmdoQKgPHeTu+DfO+WesNLefN3po0
        R9NLCarCPlMgTyosDYGCmIU+OFXfYoedIUeJqf22LVR7R7WTOJIFAY9q5u3r9V4b43Ynpm
        HwcHrcODHBHUS8nc5lhJa/98sGVBFMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652773016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5k0bGOWkmGL1ogvQ/PreqJMh1U1K6c4WBr2eA6nTSAM=;
        b=Z7Cu/hEg/PUSiAGDXraTHHfvdp/4d1ELwywNgsiUNKfH1qhjPTS9AIU7zlSRB73PQws//V
        lEnTbGxt5LhUgrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B88A13305;
        Tue, 17 May 2022 07:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ueW0BpdQg2LmeQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 17 May 2022 07:36:55 +0000
Date:   Tue, 17 May 2022 09:36:53 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 2/7] mm: hugetlb_vmemmap: use kstrtobool for
 hugetlb_vmemmap param parsing
Message-ID: <YoNQlbaaUE+3+zE8@localhost.localdomain>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516102211.41557-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516102211.41557-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 06:22:06PM +0800, Muchun Song wrote:
> Use kstrtobool rather than open coding "on" and "off" parsing in
> mm/hugetlb_vmemmap.c,  which is more powerful to handle all kinds
> of parameters like 'Yy1Nn0' or [oO][NnFf] for "on" and "off".
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
