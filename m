Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25302C38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 14:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiIBOgZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiIBOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:35:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCE16B1F0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662127007; x=1693663007;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=0C4Mrc8p7r2/pndSczNhemjcNNdk967OJeL9PozTUO8=;
  b=I7qnQz2hmBlQA08T7qylaNvtzYO1wGF6Z4PI9lV6d3exfjSpGnHS1Xf3
   qefTRUnN8jcJPaLsBYDU7KWezIVohPLabdq2dwNuBl/mG2BDIGxZ3NYOJ
   mqkquJQKfxVvBKkfd21XkEloJMAEgSojLh2g4tDNwaepo6cOoVtakXUJT
   t/3Jz3FDhMjL1+WSRnXktJSmjfPSF6wCrJ30MX4jwAgkH1kSUOuEShEkD
   Qh1kO/R7bBJ8EUVD7JvM9jbkSn1sv/JQqxeEK6rX7S4Is5G7KqXZqH7Zq
   lCYQklzItDc0X3dy9N/JYdkLAIHHgXYjQz23Uq9MPTeTdmYfgG+VvyQsY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294723887"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="294723887"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:56:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674362317"
Received: from svandene-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:56:41 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 2/2] drm/tests: Change "igt_" prefix to "test_drm_"
In-Reply-To: <20220902133828.ufwp6bgzd37yu6bv@nostramo.hardline.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220901124210.591994-1-mairacanal@riseup.net>
 <20220901124210.591994-2-mairacanal@riseup.net>
 <20220901125530.b56s4zisnkfuigvc@houat>
 <04aeba53-793c-3196-3137-915f0640dc2a@riseup.net>
 <87h71qfbi9.fsf@intel.com> <20220902123400.5ljgc7z6zw34d64m@houat>
 <87mtbidj3b.fsf@intel.com>
 <20220902133828.ufwp6bgzd37yu6bv@nostramo.hardline.pl>
Date:   Fri, 02 Sep 2022 16:56:30 +0300
Message-ID: <87bkrxev75.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Sep 2022, Micha=C5=82 Winiarski <michal.winiarski@intel.com> wro=
te:
> Having said that - I do believe that igt_* prefix don't belong here
> (which is why I'm progressively trying to get rid of in the patches
> that refactor some of the tests).

Just clarifying that I'm not trying to defend igt_ prefix at all, and I
agree we should get rid of it.

BR,
Jani.

--=20
Jani Nikula, Intel Open Source Graphics Center
