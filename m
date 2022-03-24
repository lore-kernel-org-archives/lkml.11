Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C6EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 18:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352578AbiCXSSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352575AbiCXSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:18:51 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D361B7170;
        Thu, 24 Mar 2022 11:17:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648145837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Xdg6AguU1tCjET4IpuuuOj6DcGbMJAnyZKDx5p9X6o=;
        b=CaznleEkIgnUPwdpezvS7Q1Z4Lx0QM+qd453HpZhRxWImtUouqJZERSIMyPP1D2gE8ZEgK
        hunDJ2I4gzVQNoBZ4dAQD8M976MYphFJnDpz5hcIVyr8TlmscQS2WpsWbWgfK1i5SJvIAc
        0p6Mq5sqgguQ1ED1eaSfq88c1oCQ5Go=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [RFC PATCH] mm: memcg: Do not count memory.low reclaim if it does not happen
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <20220324095157.GA16685@blackbody.suse.cz>
Date:   Thu, 24 Mar 2022 11:17:14 -0700
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>
Message-Id: <5049EBC3-5BAE-4509-BA63-1F4A7D913517@linux.dev>
References: <20220324095157.GA16685@blackbody.suse.cz>
To:     =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 24, 2022, at 2:52 AM, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>=20
> =EF=BB=BFOn Wed, Mar 23, 2022 at 02:44:24PM -0700, Roman Gushchin <roman.g=
ushchin@linux.dev> wrote:
>> Does it mean that in the following configuration:
>>    `parent .low=3D50M
>>      ` s1    .low=3D0M   .current=3D50M
>>      ` s2  .low=3D0M   .current=3D50M
>> there will be no memory.events::low at all? (assuming the recursive thing=
 is on)
>=20
> True, no memory.events:low among siblings.
> Number of memory.events:low in the parent depends on how much has to be
> reclaimed (>50M means carving into parent's protection, hence it'll be
> counted).

Ok, so it=E2=80=99s not really about the implementation details of the recla=
im mechanism (I mean rounding up to the batch size etc), it=E2=80=99s a more=
 generic change: do not generate low events for cgroups not explicitly prote=
cted by a non-zero memory.low value.

Idk, I don=E2=80=99t have a strong argument against this change (except that=
 it changes the existing behavior), but I also don=E2=80=99t see why such ev=
ents are harmful. Do you mind elaborating a bit more?

Thank you!=
