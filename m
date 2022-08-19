Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6988EC00140
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 02:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbiHSCuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 22:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiHSCuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:50:09 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38167C8883;
        Thu, 18 Aug 2022 19:50:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660877406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYIsY5mx18jT1W5YWBYgwJ8DWWMfAy3Bs6ffZMILCRs=;
        b=CR/u5sH6Cfh7C7IlHe1ctWkE5BDr6NNchQVQ754cozZj8n2FQksfcPjWXN73HcwHuqBO60
        Dqe8cuDieqzP05CtqQ3+6dS0rNsD/GkfqSkWxUHrjmbnsHUixTKC1cpKGI0aN9m6wBaHUT
        0CmmaE34OIbKBNi/1qAwQYJRrkOWD5I=
MIME-Version: 1.0
Subject: Re: [PATCH 02/13] docs: update vmemmap_dedup.rst reference
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2c81bc7ef207f0a84387a5d714601513f4bf1960.1660829433.git.mchehab@kernel.org>
Date:   Fri, 19 Aug 2022 10:49:34 +0800
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54AE2D05-3F4B-4A0B-B514-677D35BE85A1@linux.dev>
References: <cover.1660829433.git.mchehab@kernel.org>
 <2c81bc7ef207f0a84387a5d714601513f4bf1960.1660829433.git.mchehab@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 18, 2022, at 21:38, Mauro Carvalho Chehab <mchehab@kernel.org> =
wrote:
>=20
> Changeset ee65728e103b ("docs: rename Documentation/vm to =
Documentation/mm")
> renamed: Documentation/vm/vmemmap_dedup.rst
> to: Documentation/mm/vmemmap_dedup.rst.
>=20
> Update its cross-reference accordingly.
>=20
> Fixes: ee65728e103b ("docs: rename Documentation/vm to =
Documentation/mm")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>=20

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

