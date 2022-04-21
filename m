Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 20:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392276AbiDUUTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiDUUTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:19:50 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6739B;
        Thu, 21 Apr 2022 13:16:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650572217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Krrtc5iqhLr+EB3Tf4IiuGpydLgVWU6oPUZIW+tfTdQ=;
        b=CuR9SYzh063IpeWf/1rCjN8R7huXRX0Obf7z/4w6fEfb/n2My3rNnbrcwGJt2n03OG4+0v
        p5dEVDffQwBule/5bevmW98pSlEb0pz1fPg+g/y8IukfzUSxmgW7PTnylnq3zdqYm+nl5r
        8VIEDYPdziI5Bc5i/PGuQOKNmENsQhk=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] MAINTAINERS: add corresponding kselftests to cgroup entry
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <YmGvwPIAA1LqCcku@slm.duckdns.org>
Date:   Thu, 21 Apr 2022 13:16:54 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>
Message-Id: <CCF18068-862D-4774-93B8-3DA6D487B94E@linux.dev>
References: <YmGvwPIAA1LqCcku@slm.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 21, 2022, at 12:25 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Apr 14, 2022 at 05:01:32PM -0700, Roman Gushchin wrote:
>> List cgroup kselftests in the cgroup MAINTAINERS entry.
>> These are tests covering core, freezer and cgroup.kill
>> functionality.
>>=20
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Zefan Li <lizefan.x@bytedance.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: cgroups@vger.kernel.org
>=20
> Acked-by: Tejun Heo <tj@kernel.org>
> I suppose this can go with the rest through -mm? Please let me know if I
> should pick it up.

Yep, Andrew picked it up already.

Thanks!
