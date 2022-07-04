Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32E1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 08:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGDIkL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiGDIkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:40:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C4B7C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:40:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1678C204F5;
        Mon,  4 Jul 2022 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656924008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAYqgNHe+/uVIKSDCjLSGa9XJUl+x4S9hGoqojL6V6o=;
        b=CREG25cc4wRHMfTqjWsv4PQ+Qd36hXvb0ony0kCGx1RPa1wq94gEqtzXlFMCs/4F/LN5y7
        LPhicNQC+93soJZ1n52a4gDk+YBcVuOb8lbqkqWD6SgkNcaVsYfWTCGl2klODxdnl3Upik
        CTWJnml0ehq51GSnx+gGpBAY8khEkq0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 892592C146;
        Mon,  4 Jul 2022 08:40:07 +0000 (UTC)
Date:   Mon, 4 Jul 2022 10:40:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
Message-ID: <YsKnZ++HZcOPOhCS@dhcp22.suse.cz>
References: <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
 <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
 <Yr7qQsWQGb0dhkxr@dhcp22.suse.cz>
 <54b67d6b-f600-1b9b-3d3f-e91b13d04c91@redhat.com>
 <Yr70ZwUAIHNz5VNy@dhcp22.suse.cz>
 <11d28e6d-edb0-7d11-b476-c5808f3b7c5d@redhat.com>
 <YsKNJiGA/ruLRS27@dhcp22.suse.cz>
 <62c296e6.1c69fb81.41c44.1cca@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c296e6.1c69fb81.41c44.1cca@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-07-22 07:29:41, CGEL wrote:
[...]
> Maybe new semantics is needed similarly to MADV_NOHUGEPAGE that ensures that
> there will *not* be huge pages.

How do you achieve that with a backward compatibility?

-- 
Michal Hocko
SUSE Labs
